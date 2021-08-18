//
//  NetworkRequest.swift
//  assignment
//
//  Created by Abhishek on 17/08/21.
//

import Foundation


protocol NetworkRequest {
    var url: URL { get set }
    var method: HttpMethods {get set}
}

public struct Request: NetworkRequest {
    var url: URL
    var method: HttpMethods
    var requestBody: Data? = nil

    init(withUrl url: URL, forHttpMethod method: HttpMethods, requestBody: Data? = nil) {
        self.url = url
        self.method = method
        self.requestBody = requestBody != nil ? requestBody : nil
    }
}
