//
//  RandomImageRequest.swift
//  CNTIOSBootstrapApp
//
//  Created by Neil Francis Hipona on 4/19/22.
//

import Alamofire
import Combine
import Foundation
import UIKit

enum RandomImageAPI {
    case imageBy1000
    case imageBy2000
    case imageBy3000
}

extension RandomImageAPI: APIRequestProtocol {

    var baseURL: URL {
        URL(string: "https://picsum.photos")!
    }

    var path: String {
        switch self {
        case .imageBy1000:
            return "/1000"
        case .imageBy2000:
            return "/2000"
        case .imageBy3000:
            return "/3000"
        }
    }

    var fullURL: URL {
        baseURL.appendingPathComponent(path)
    }

    var method: APIHTTPMethod {
        .get
    }

    var headers: APIHTTPHeaders? {
        nil
    }

    var queryParameters: Parameters? {
        nil
    }

    var parameters: Parameters? {
        nil
    }
}

extension RandomImageAPI: APIRepositoryProtocol {

    func responseProcessor<API>(api: API, publisher: PassthroughSubject<APIResponse, Never>, data: Data, shouldFinishImmediately: Bool) where API : APIRequestProtocol {
        if let image = UIImage(data: data) {
            publisher.send(.success(data: RandomImage(message: "\(image)")))

            if shouldFinishImmediately {
                publisher.send(completion: .finished)
            }
        } else {
            APIService.processErrorAndSuccessOnlyResponse(publisher: publisher, data: data, shouldFinishImmediately: shouldFinishImmediately)
        }
    }
}
