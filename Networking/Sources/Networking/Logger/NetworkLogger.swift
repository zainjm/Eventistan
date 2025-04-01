//
//  NetworkLogger.swift
//  Networking
//
//  Created by Zain Ul Abe Din on 06/01/2025.
//

import Foundation
import Pulse

protocol NetworkLoggerType {
    func logTaskCreated(_ task: URLSessionTask)
    func logDataTask(_ task: URLSessionDataTask, didReceive data: Data)
    func logTask(_ task: URLSessionTask, didCompleteWithError: Error?)
    func logTask(_ task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics)
}

extension NetworkLogger: NetworkLoggerType { }

enum AppNetworkLogger {
    static func log(request: URLRequest) {
        #if DEBUG
        var output = [String]()
        output.append("<--- REQUEST --->")
        output.append("Request: \(request.description)")
        if let httpRequestHeaders = request.allHTTPHeaderFields {
            output.append("Request Headers: \(httpRequestHeaders.description)")
        }
        if let bodyStream = request.httpBodyStream {
            output.append("Request Body Stream: \(bodyStream.description)")
        }
        if let body = request.httpBody, let stringOutput = String(data: body, encoding: .utf8) {
            output.append("Request Body: \(stringOutput)")
        }
        if let method = request.httpMethod {
            output.append("HTTP Request Method: \(method)")
        }
        output.append("<--------------->")
        print(output.joined(separator: "\n"))
        #endif
    }
    
    static func log(response: URLResponse, data: Data? = nil) {
        #if DEBUG
        var output = [String]()
        output.append("<--- RESPONSE --->")
        output.append("Response: \(response.description)")
        if let body = data, let stringData = jsonResponseDataFormatter(body) {
            output.append("Response Body: \(stringData)")
        }
        output.append("<---------------->")
        print(output.joined(separator: "\n"))
        #endif
    }
    
    private static func jsonResponseDataFormatter(_ data: Data) -> String? {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8)
        } catch {
         return String(data: data, encoding: .utf8)
        }
    }
}

extension URLRequest {
    func log() {
        AppNetworkLogger.log(request: self)
    }
}

extension URLResponse {
    func log(data: Data? = nil) {
        AppNetworkLogger.log(response: self, data: nil)
    }
}
