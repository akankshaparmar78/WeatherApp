//
//  UIViewController+Extension.swift
//  WeatherApp
//
//  Created by apple on 19/03/25.
//

import Foundation
import UIKit

extension UIViewController {
    
  func alert(message: String, title: String = "") {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(OKAction)
    self.present(alertController, animated: true, completion: nil)
  }
    
}
