//
//  WeatherApp_FinalTaskTests.swift
//  WeatherApp_FinalTaskTests
//
//  Created by Ivan Simunovic on 12.02.2021..
//


import Cuckoo
import Quick
import Nimble
import Combine
import UIKit

@testable import WeatherApp_FinalTask

class WeatherApp_FinalTaskTests: QuickSpec {
    
    func getResource<T: Codable>() -> T? {
        let bundle = Bundle.init(for: WeatherApp_FinalTaskTests.self)
        
        guard let resourcePath = bundle.url(forResource: "MockWeatherResponseJSON", withExtension: "json"),
        let data = try? Data(contentsOf: resourcePath),
        let parsedData: T = SerializationManager.parseData(jsonData: data) else {
            return nil
        }
        return parsedData
    }
    
override func spec() {
    let mock = MockCurrentWeatherRepositoryImpl()
    var disposeBag = Set<AnyCancellable>()
    
    describe("FirstScreen repository test") {
        it("has correct weather data ") {
                // ARRANGE
            stub(mock) { [unowned self] stub in
                
                if let data: WeatherInformation = self.getResource() {
                    let publisher = CurrentValueSubject<WeatherInformation, NetworkError>(data).eraseToAnyPublisher()
                    when(stub).getCurrentWeatherInformation()
                } else {
                    print("didnt enter")
                    }
            }
        //let expected:
        //var actual:
                            // ACT
                        
            waitUntil { (done) in

                }
        // ASSERT
                
        //expect(actual).to(equal(expected))
                
            }
        }
    }
}
