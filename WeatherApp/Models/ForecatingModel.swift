//
//  ForecatingModel.swift
//  WeatherApp
//
//  Created by apple on 19/03/25.
//

import Foundation

// MARK: - Welcome
struct ForecatingModel: Codable {
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City1
}

// MARK: - City
struct City1: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population, timezone, sunrise, sunset: Int
}

// MARK: - List
struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather1]
    let clouds: Clouds
    let wind: Wind1
    let visibility: Int
    let pop: Double
    let sys: Sys1
    let dtTxt: String
    let rain: Rain?

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, visibility, pop, sys
        case dtTxt = "dt_txt"
        case rain
    }
}


// MARK: - MainClass
struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int
    let tempKf: Double

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

// MARK: - Rain
struct Rain: Codable {
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
}

// MARK: - Sys
struct Sys1: Codable {
    let pod: Pod
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

// MARK: - Weather
struct Weather1: Codable {
    let id: Int
    let main: MainEnum
    let description: String
    let icon: String
}

enum MainEnum: String, Codable {
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
}

// MARK: - Wind
struct Wind1: Codable {
    let speed: Double
    let deg: Int
    let gust: Double
}
