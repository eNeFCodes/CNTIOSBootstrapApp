//
//  APIHTTPHeader.swift
//  CNTIOSBootstrapApp
//
//  Created by Neil Francis Hipona on 4/29/22.
//

import Foundation

enum APIHTTPHeaderKey: String, Codable, CodingKeyRepresentable {
    case contentType
    case authorization

    enum CodingKeys: String, CodingKey {
        case contentType = "Content-Type"
        case authorization = "Authorization"
    }
}

typealias APIHTTPHeader = [APIHTTPHeaderKey: String]

struct APIHTTPHeaders {
    var headers: [APIHTTPHeader] = []

    
}
