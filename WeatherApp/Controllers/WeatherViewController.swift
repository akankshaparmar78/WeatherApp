//
//  ViewController.swift
//  WeatherApp
//
//  Created by apple on 19/03/25.
//

import UIKit

import UIKit

class WeatherViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatheTypeImageView: UIImageView!
    @IBOutlet weak var tempretureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    var currentWeather: CurrentWeatherModel?
    var currentCityWeather: CurrentWeatherModel?
    var forcasting: ForecatingModel?
    var currentCityforcasting: ForecatingModel?
    var cityManager = LocationManager.shared

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchCurrentCityWeather()
    }

    // MARK: - UI Configuration
    func configureUI() {
        activityIndicator.hidesWhenStopped = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ForcatTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ForcatTableViewCell.identifier)
        searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }

    func setUI() {
        guard let currentWeather = currentWeather else { return }
        DispatchQueue.main.async {
            self.cityNameLabel.text = currentWeather.name
            self.descriptionLabel.text = currentWeather.weather[0].description
            self.tempretureLabel.text = "\(currentWeather.main.temp)℃"
            if let image = HelperFunction.shared.weatherImage(icon: currentWeather.weather[0].icon) {
                self.weatheTypeImageView.image = image
            }
            self.tableView.reloadData()
        }
    }

    // MARK: - Actions
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let cityName = searchTextField.text, !cityName.isEmpty else {
            self.alert(message: "Please enter city name", title: "Warning")
            return
        }
        activityIndicator.startAnimating()
        getCurrentWeatherAPI(cityName) {
            self.getForcastingWeatherAPI(cityName)
        }
    }

    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.isEmpty {
            self.currentWeather = currentCityWeather
            self.forcasting = currentCityforcasting
            setUI()
        }
    }

    // MARK: - Networking
    func fetchCurrentCityWeather() {
        cityManager.getCurrentCity { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cityName):
                self.activityIndicator.startAnimating()
                self.getCurrentWeatherAPI(cityName) {
                    self.getForcastingWeatherAPI(cityName)
                }
            case .failure(let error):
                print("Error getting city name: \(error)")
            }
        }
    }

    func getCurrentWeatherAPI(_ cityName: String, isFromSeacrh: Bool = false, completion: @escaping () -> Void) {
        NetworkServices.shared.getCurrentWeather(for: cityName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if isFromSeacrh {
                    self.currentWeather = data
                } else {
                    self.currentCityWeather = data
                    self.currentWeather = data
                }
                self.setUI()
                completion()
            case .failure(let error):
                print("Error: \(error)")
                completion()
            }
        }
    }

    func getForcastingWeatherAPI(_ cityName: String, isFromSeacrh: Bool = false) {
        NetworkServices.shared.getForcastingWeather(for: cityName) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { self.activityIndicator.stopAnimating() }
            switch result {
            case .success(let data):
                if isFromSeacrh {
                    self.forcasting = data
                } else {
                    self.currentCityforcasting = data
                    self.forcasting = data
                }
                self.setUI()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
}

// MARK: - TableView Delegate & DataSource
extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forcasting?.list.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: ForcatTableViewCell.identifier) as! ForcatTableViewCell
        if let forcasting = forcasting?.list[indexPath.row] {
            cell.setData(forcasting: forcasting)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
}
