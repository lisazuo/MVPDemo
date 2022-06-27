//
//  WeatherData.swift
//  MVPDemo
//
//  Created by lisa on 20/06/22.
//

import Foundation

enum LocationName: String {
    case Beijing, Tokyo, Canada, NewZealand
    static func getLocation(locationName: String) -> LocationName {
        switch locationName {
        case "Tokyo":
            return  .Tokyo
        case "Canada":
            return .Canada
        case "New Zealand", "NewZealand":
            return .NewZealand
        default:
            return .Beijing
        }
    }
}

//class that represents the data returned by the Weatherbit API
class WeatherModel: Codable {
    var locationName: String
    let iconName: String
    //    let date: NSDate
    let date: String
    let currentTemp: Double
    let description: String
    let latitude: Double
    let longitude: Double
    
    enum Codingkeys: String, CodingKey {
        case locationName, iconName, date, currentTemp, description, latitude, longitude
    }
    // initilizer
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Codingkeys.self)
        locationName = try container.decode(String.self, forKey: .locationName)
        iconName = try container.decode(String.self, forKey: .iconName)
        date = try container.decode(String.self, forKey: .date)
        currentTemp = try container.decode(Double.self, forKey: .currentTemp)
        description = try container.decode(String.self, forKey: .description)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
}
