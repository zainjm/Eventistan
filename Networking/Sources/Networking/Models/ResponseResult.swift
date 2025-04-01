//
//  ResponseResult.swift
//
//
//  Created by Zain Ul Abe Din on 05/11/2024.
//

import Foundation

enum ResponseResult {
  case success
  case failure
}
extension HTTPURLResponse {
  var result: ResponseResult {
    if (200...299).contains(statusCode) {
      return .success
    } else {
      return .failure
    }
  }
}
