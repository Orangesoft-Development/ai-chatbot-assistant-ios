//
//  WeatherService.swift
//  AIChatbotDemo
//
//  Created by Maxim Brishten on 2.02.24.
//

import Foundation

class WeatherService {
    
    static let shared = WeatherService()
    private init() {}
    
    func getCurrentWeatherTemp(for city: String) async throws -> Double {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(AppConstants.weatherApiKey)&units=metric") else {
            throw WeatherError.invalidURL
        }

        let urlRequest = URLRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw WeatherError.invalidResponse
            }

            let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)
            let temperature = decodedData.main.temp

            return temperature
        } catch {
            throw error
        }
    }
}

struct ResponseBody: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse

    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }

    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }

    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }

    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension ResponseBody.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}

enum WeatherError: Error {
    case invalidURL
    case invalidResponse
}
