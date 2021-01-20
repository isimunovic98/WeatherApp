//
//  NetworkError.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 17.01.2021..
//

import Foundation

public enum NetworkError: Error {
    case generalError
    case parseFailed
    case invalidUrl
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .parseFailed:
            return "Parse failed"
        case .generalError:
            return "An error occured, please try again"
        case .invalidUrl:
            return "Invalid URL"
        }
    }
}
