//
//  WeatherService.swift
//  MVPDemo
//
//  Created by lisa on 20/06/22.
//

import Foundation

//fetches the weather data 
class WeatherService {
    static func weatherDataForLocation(locationName: String,
                                       completion: ((Result<WeatherModel, Error>) -> Void)) {
        let realLocation = LocationName.getLocation(locationName: locationName).rawValue
        let fileURL = Bundle.main.path(forResource: "weatherData.geojson", ofType: nil)
        do {
            let url = URL(fileURLWithPath: fileURL!)
            let data = try! Data.init(contentsOf: url)
            let weatherModelList = try JSONDecoder().decode([WeatherModel].self, from: data)
            let weatherModel = weatherModelList.filter({ $0.locationName == realLocation}).first!
            completion(.success(weatherModel))
        }
        catch {
            completion(.failure(error))
        }
    }
}
