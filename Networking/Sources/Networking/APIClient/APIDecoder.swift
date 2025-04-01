//
//  APIDecoder.swift
//
//
//  Created by Zain Ul Abe Din on 03/10/2024.
//

import Foundation
import Types

protocol APIDecoderType {
    func decode<T: Decodable>(
        _ apiResponse: Result<APISuccess, APIFailure>,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy
    ) -> Result<T, APIFailure>
}

final class APIDecoder: APIDecoderType {
    // MARK: - Properties
    private let tracker: TrackerType
    
    // MARK: - Constants
    private enum Constant {
        static let dataParsingFailure = "Data parsing failure"
        static let dataNotFoundFailure = "Data not found"
        static let error = "error"
    }
    
    // MARK: - Initialization
    init(tracker: TrackerType) {
        self.tracker = tracker
    }
    
    // MARK: - Decoding
    func decode<T: Decodable>(
        _ apiResponse: Result<APISuccess, APIFailure>,
        dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .millisecondsSince1970
    ) -> Result<T, APIFailure> {
        switch apiResponse {
        case .success(let success):
            guard let data = success.data else {
                return .failure(APIFailure(
                    data: Constant.dataNotFoundFailure.data(using: .utf8),
                    responseCode: success.responseCode
                ))
            }
            
            if data.isEmpty, let model = success.responseCode as? T {
                return .success(model)
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = dateDecodingStrategy
                let model: T = try decoder.decode(T.self, from: data)
                return .success(model)
            } catch {
                debugPrint(error)
                return .failure(APIFailure(
                    data: error.localizedDescription.data(using: .utf8),
                    responseCode: success.responseCode
                ))
            }
        case .failure(let failure):
            return .failure(failure)
        }
    }
}
