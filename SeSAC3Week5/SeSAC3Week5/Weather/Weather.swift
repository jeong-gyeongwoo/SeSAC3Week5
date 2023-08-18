//
//  Weather.swift
//  SeSAC3Week5
//
//  Created by 정경우 on 2023/08/17.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieInfo = try? JSONDecoder().decode(MovieInfo.self, from: jsonData)

import Foundation

// MARK: - WeatherData
struct WeatherData: Codable {
    let weather: [Weather]
    let timezone: Int
    let coord: Coord
    let wind: Wind
    let base: String
    let sys: Sys
    let id, dt: Int
    let main: Main
    let cod: Int
    let clouds: Clouds
    let visibility: Int
    let name: String
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let grndLevel: Int
    let feelsLike, tempMin, tempMax: Double
    let seaLevel, pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case grndLevel = "grnd_level"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case seaLevel = "sea_level"
        case pressure, humidity
    }
}

// MARK: - Sys
struct Sys: Codable {
    let sunset: Int
    let country: String
    let type, sunrise, id: Int
}

// MARK: - Weather
struct Weather: Codable {
    let main, icon, description: String
    let id: Int
}

// MARK: - Wind
struct Wind: Codable {
    let deg: Int
    let gust, speed: Double
}
