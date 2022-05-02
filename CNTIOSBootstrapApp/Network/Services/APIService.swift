//
//  APIService.swift
//  CNTIOSBootstrapApp
//
//  Created by Neil Francis Hipona on 4/19/22.
//

import Alamofire
import Combine
import Foundation

class APIService {

    static let NetworkRequestQueue = DispatchQueue(label: "com.CNTIOSBootstrapApp.NetworkRequestQueue",
                                                   qos: .background,
                                                   attributes: .concurrent,
                                                   autoreleaseFrequency: .workItem,
                                                   target: .global())

    static let NetworkRequestCompletionQueue = DispatchQueue(label: "com.CNTIOSBootstrapApp.NetworkRequestCompletionQueue",
                                                             qos: .userInteractive,
                                                             attributes: .concurrent,
                                                             autoreleaseFrequency: .workItem,
                                                             target: .global())

    private func processRequest<Request>(api: Request) async throws -> (Data, URLResponse) where Request: APIRequestProtocol {
        var request = URLRequest(url: api.fullURL,
                                         cachePolicy: .reloadRevalidatingCacheData,
                                         timeoutInterval: TimeInterval(500))
        request.httpMethod = api.method.rawValue

        if let allHeaders = api.headers?.all as? [String : String] {
            request.allHTTPHeaderFields = allHeaders
        }

        let response = try await URLSession.shared.data(for: request)
        return response
    }

    func request<Request>(api: Request) async -> AnyPublisher<APIResponse, Never> where Request: APIRequestProtocol {
        // check internet and send internet error
        let publisher = PassthroughSubject<APIResponse, Never>()

        do {
            let (data, _) = try await processRequest(api: api)
            api.responseProcessor(api: api, publisher: publisher, data: data, shouldFinishImmediately: true)
        } catch {
            publisher.send(.error(error: .unknown))
            publisher.send(completion: .finished)
        }

        return publisher.eraseToAnyPublisher()
    }

    // use for multiple request instance - ignores request order
    func request<Request>(apis: [Request]) async -> AnyPublisher<APIResponse, Never> where Request: APIRequestProtocol {
        // check internet and send internet error

        let group = DispatchGroup()
        let publisher = PassthroughSubject<APIResponse, Never>()

        for api in apis {
            group.enter() // send enter dispatch
            async let response = processRequest(api: api)

            do {
                let data = try await response.0
                api.responseProcessor(api: api, publisher: publisher, data: data, shouldFinishImmediately: false)
                group.leave()
            } catch {
                group.leave()
            }
        }

        group.notify(queue: APIService.NetworkRequestCompletionQueue) {
            publisher.send(completion: .finished)
        }

        return publisher.eraseToAnyPublisher()
    }
}

extension APIService {

    class func processErrorAndSuccessOnlyResponse(publisher: PassthroughSubject<APIResponse, Never>, data: Data, shouldFinishImmediately: Bool) {
        if let error = try? JSONDecoder().decode(APIResponseError.self, from: data) {
            publisher.send(.error(error: .responseError(error: error)))
        } else {
            publisher.send(.error(error: .errorMessage(message: APIServiceError.ErrorTypeConversionFailed)))
        }

        if shouldFinishImmediately {
            publisher.send(completion: .finished)
        }
    }
}
