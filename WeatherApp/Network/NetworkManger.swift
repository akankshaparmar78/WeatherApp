//
//  NetworkManger.swift
//  WeatherApp
//
//  Created by apple on 19/03/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case decodingFailed
}

class  NetworkManager{
    
  static let shared = NetworkManager()
    
    func fetchData<T: Decodable>(from urlString: String, responseType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        print(url)

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }

            guard let data = data else {
                completion(.failure(.requestFailed))
                return
            }

            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response in JSON format: \(jsonString)")
            }
            
            do {
                
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print("Decoding failed with error: \(error.localizedDescription)")
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}


class NetworkServices{

    static let shared = NetworkServices()
    let baseURL = "https://api.openweathermap.org/data/2.5/"
    let APIKey = "5e03b4aa68b8528ab4ed90746fc274e0"
    
    func getCurrentWeather(for cityName: String, completion: @escaping (Result<CurrentWeatherModel, NetworkError>) -> Void) {
        let  urlString = "\(baseURL)weather?q=\(cityName)&appid=\(APIKey)&units=metric"
        NetworkManager.shared.fetchData(from: urlString, responseType: CurrentWeatherModel.self, completion: completion)
    }
    
    func getForcastingWeather(for cityName: String, completion: @escaping (Result<ForecatingModel, NetworkError>) -> Void) {
        let  urlString = "\(baseURL)forecast?q=\(cityName)&appid=\(APIKey)&units=metric"
        NetworkManager.shared.fetchData(from: urlString, responseType: ForecatingModel.self, completion: completion)
    }
    
}
