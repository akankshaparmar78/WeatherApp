//
//  HelperFunction.swift
//  WeatherApp
//
//  Created by apple on 19/03/25.
//

import Foundation
import UIKit

class HelperFunction{
    
    static let shared = HelperFunction()
    
    func weatherImage(icon: String) -> UIImage? {
        switch icon {
        case "01d":
            return UIImage(systemName: "sun.max.fill")
        case "01n":
            return UIImage(systemName: "moon.fill")
        case "02d":
            return UIImage(systemName: "cloud.sun.fill")
        case "02n":
            return UIImage(systemName: "cloud.moon.fill")
        case "03d", "03n":
            return UIImage(systemName: "cloud.fill")
        case "04d", "04n":
            return UIImage(systemName: "smoke.fill")
        case "09d", "09n":
            return UIImage(systemName: "cloud.rain.fill")
        case "10d", "10n":
            return UIImage(systemName: "cloud.heavyrain.fill")
        case "11d", "11n":
            return UIImage(systemName: "cloud.bolt.fill")
        case "13d", "13n":
            return UIImage(systemName: "snowflake")
        case "50d", "50n":
            return UIImage(systemName: "cloud.fog.fill")
        default: return UIImage(systemName: "questionmark.circle")
        }
    }
    
}
