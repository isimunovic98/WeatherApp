//
//  GeoNamesCity.swift
//  WeatherApp_FinalTask
//
//  Created by Ivan Simunovic on 19.01.2021..
//

import Foundation

struct GeoNames: Codable {
    var results: [CityInformation]
    
    enum CodingKeys: String, CodingKey {
        case results = "geonames"
    }
}

struct CityInformation: Codable {
    var toponymName: String
    var name: String
}
