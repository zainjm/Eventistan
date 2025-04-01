//
//  NetworkEventMonitor.swift
//  Networking
//
//  Created by Zain Ul Abe Din on 06/01/2025.
//

import Alamofire
import Foundation

protocol NetworkEventMonitorType: EventMonitor {
    func addNetworkLogger(_ logger: NetworkLoggerType)
    func removeLoggers()
}

class NetworkEventMonitor: NetworkEventMonitorType {
    // MARK: - Properties
    private var loggers: [NetworkLoggerType] = []
    
    // MARK: - Functions
    func addNetworkLogger(_ logger: any NetworkLoggerType) {
        loggers.append(logger)
    }
    
    func removeLoggers() {
        loggers.removeAll()
    }
    
    func request(_ request: Request, didCreateTask task: URLSessionTask) {
        loggers.forEach({ $0.logTaskCreated(task) })
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        loggers.forEach({ $0.logDataTask(dataTask, didReceive: data) })
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        loggers.forEach({ $0.logTask(task, didFinishCollecting: metrics) })
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        loggers.forEach({ $0.logTask(task, didCompleteWithError: error) })
    }
}
