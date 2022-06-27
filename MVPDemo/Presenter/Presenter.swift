//
//  Presenter.swift
//  MVPDemo
//
//  Created by Lisa on 24/06/22.
//get data and tell view to present data

import Foundation

//tell view to present data
protocol presenterDelegate: AnyObject {
    func presentData(viewModel: WeatherModel)
}

class Presenter {
    weak var delegate: presenterDelegate?
    
    func getData(locationName: String) {
        WeatherService.weatherDataForLocation(locationName: locationName) { [weak self]  result in
            switch result {
            case .success(let weatherModel):
                self?.delegate?.presentData(viewModel: weatherModel)
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }
}
