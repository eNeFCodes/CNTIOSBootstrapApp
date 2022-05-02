//
//  APIRequestProtocol.swift
//  CNTIOSBootstrapApp
//
//  Created by Neil Francis Hipona on 4/19/22.
//

import Combine
import Foundation

typealias Parameters = [String: Any]

protocol APIRequestProtocol: APIRepositoryProtocol {
    /// Format: Environment.API_URL
    var baseURL: URL { get }
    /// Format: "/url-path"
    var path: String { get }
    /// Format: baseURL.appendingPathComponent(path)
    var fullURL: URL { get }
    var method: APIHTTPMethod { get }
    var headers: APIHTTPHeaders? { get }
    var queryParameters: Parameters? { get }
    var parameters: Parameters? { get }
}
