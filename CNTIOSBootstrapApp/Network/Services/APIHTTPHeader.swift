//
//  APIHTTPHeader.swift
//  CNTIOSBootstrapApp
//
//  Created by Neil Francis Hipona on 5/2/22.
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

    var all: Parameters {
        var parameters: Parameters = [:]
        for header in headers {
            guard let key = header.keys.first, let value = header.values.first else { continue }
            parameters[key.rawValue] = value
        }
        return parameters
    }
}
