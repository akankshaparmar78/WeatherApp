//
//  ForcatTableViewCell.swift
//  WeatherApp
//
//  Created by apple on 19/03/25.
//

import UIKit

class ForcatTableViewCell: UITableViewCell {
    
    static let identifier = "ForcatTableViewCell"
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatheTypeImageView: UIImageView!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code)
    }
    
    func setData(forcasting:List){
        DispatchQueue.main.async{
            self.dayLabel.text = forcasting.dtTxt
            self.descriptionLabel.text = forcasting.weather[0].description
            self.tempretureLabel.text = "\(forcasting.main.temp)℃"
            if let image = HelperFunction.shared.weatherImage(icon:forcasting.weather[0].icon){
                self.weatheTypeImageView.image = image
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
