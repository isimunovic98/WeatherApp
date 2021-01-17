//
//  RestManager.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 15.01.2021..
//

import Foundation
import Alamofire
import Combine
public enum NetworkError: Error {
    case generalError
    case parseFailed
}

public class RestManager {
    private static let manager: Alamofire.Session = {
        var configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 50
        configuration.timeoutIntervalForResource = 50
        let sessionManager = Session(configuration: configuration)
        
        return sessionManager
    }()
    
    public static func requestObservable<T: Codable>(url: String) -> AnyPublisher<T, NetworkError> {
        return Future { promise in
            let request = RestManager.manager
                .request(url, encoding: URLEncoding.default)
                .validate()
                .responseData { (response) in
                    switch response.result {
                    case .success(let value):
                        if let decodedObject: T = SerializationManager.parseData(jsonData: value) {
                            promise(.success(decodedObject))
                        } else {
                            promise(.failure(NetworkError.parseFailed))
                        }
                    case .failure:
                        promise(.failure(NetworkError.generalError))
                    }
                }
            request.resume()
        }.eraseToAnyPublisher()
    }
    
}