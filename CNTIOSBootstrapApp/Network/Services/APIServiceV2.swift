//
//  APIServiceV2.swift
//  CNTIOSBootstrapApp
//
//  Created by Neil Francis Hipona on 4/29/22.
//

import Combine
import Foundation

class APIServiceV2 {

    func request<Request>(api: Request) async -> AnyPublisher<APIResponse, Never> where Request: APIRequestProtocol2 {

        let request = URLRequest(url: api.fullURL,
                                 cachePolicy: .reloadRevalidatingCacheData,
                                 timeoutInterval: TimeInterval(500))
        request.method = api.method
        request.allHTTPHeaderFields

    }
    
}
