//
//  APIHTTPMethod.swift
//  CNTIOSBootstrapApp
//
//  Created by Neil Francis Hipona on 5/2/22.
//

import Foundation

struct APIHTTPMethod: RawRepresentable, Equatable, Hashable {
    /// `DELETE` method.
    public static let delete = APIHTTPMethod(rawValue: "DELETE")
    /// `GET` method.
    public static let get = APIHTTPMethod(rawValue: "GET")
    /// `PATCH` method.
    public static let patch = APIHTTPMethod(rawValue: "PATCH")
    /// `POST` method.
    public static let post = APIHTTPMethod(rawValue: "POST")
    /// `PUT` method.
    public static let put = APIHTTPMethod(rawValue: "PUT")

    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}
