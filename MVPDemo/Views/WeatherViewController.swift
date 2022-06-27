//
//  WeatherViewController.swift
//  MVPDemo
//
//  Created by lisa on 20/06/22.
import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet private weak var currentIcon: UIImageView!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var currentSummaryLabel: UILabel!
    @IBOutlet private weak var forecastSummary: UILabel!
    
    private let tempFormatter: NumberFormatter = {
        let tempFormatter = NumberFormatter()
        tempFormatter.numberStyle = .none
        return tempFormatter
    }()
    
    private let present: Presenter = Presenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        present.delegate = self
        present.getData(locationName: "Beijing")
        
    }
    
    @IBAction func promptForLocation_click(_ sender: Any) {
        //1
        let alert = UIAlertController(
            title: "Choose location",
            message: "you can choose Beijing, Tokyo, Canada or Newzealand",
            preferredStyle: .alert)
        alert.addTextField()
        //2
        let submitAction = UIAlertAction(
            title: "Submit",
            style: .default) { [unowned alert, weak self] _ in
                guard let newLocation = alert.textFields?.first?.text else { return }
                self?.present.getData(locationName: newLocation)
            }
        alert.addAction(submitAction)
        //3
        present(alert, animated: true)
    }
}

extension WeatherViewController: presenterDelegate {
    func presentData(viewModel: WeatherModel) {
        cityLabel.text = viewModel.locationName
        dateLabel.text = viewModel.date
        currentIcon.image = UIImage.init(named: viewModel.iconName)
        let temp = self.tempFormatter
        .string(from: viewModel.currentTemp as NSNumber) ?? ""
        currentSummaryLabel.text = "\(viewModel.description) - \(temp)℉"
        forecastSummary.text = "Summary: \(viewModel.description) forecast"
    }
}
