//
//  ForecastPresenterTests.swift
//  WeatherLloydsTest
//
//  Created by Divide by Zero on 06/06/2017.
//  Copyright © 2017 Divide by Zero. All rights reserved.
//

import XCTest
@testable import WeatherLloydsTest


class ForecastPresenterTests: XCTestCase {
    
    var forecastPresenter: ForecastPresenter!
    var stubForecastInteractor: StubForecastInteractor!
    
    override func setUp() {
        super.setUp()
        
        let networkingManager = NetworkingManager(session: URLSession())

        let forecastModelParser = ForecastModelParser()

        let weatherService = WeatherService(networkingManager: networkingManager, modelParser: forecastModelParser)
        
        self.stubForecastInteractor = StubForecastInteractor(weatherService: weatherService)
        
        let dayForecast = DayForecast(temp: 100.01, maxTemp: 110.053, minTemp: 100, humidity: 12, date: Date(timeIntervalSince1970: 381499523), icon: "01n")
        let mockCityForecast = CityForecast(cityName: "Madrid", countryName: "Spain", weekForecast: [dayForecast])
        stubForecastInteractor.mockCityForecast = mockCityForecast
        
        self.forecastPresenter = ForecastPresenter(interactor: stubForecastInteractor)
    }
    
    override func tearDown() {
        self.forecastPresenter = nil
        self.stubForecastInteractor = nil
        
        super.tearDown()
    }
    
    // MARK: init
    
    func test_init_retunsPresenter() {
        XCTAssertNotNil(self.forecastPresenter)
    }
    
    func test_init_setsInteractorCorrectly() {
        XCTAssertTrue(self.forecastPresenter.interactor as? StubForecastInteractor === self.stubForecastInteractor)
    }
    
    // MARK: fetchForecastViewModel
    
    func test_fetchForecastViewModel_createsCityViewModelCorrectly() {
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            XCTAssertEqual(cityForecastViewModel.cityAndCountry, "Madrid, Spain")
        }
    }
    
    func test_fetchForecastViewModel_createsCorrectNumberOfDayForecastViewModels() {
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            XCTAssertEqual(dayForecastViewModels.count, 1)
        }
    }
    
    func test_fetchForecastViewModel_createsDayForecastViewModelsWithCorrectTemp() {
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            let dayForecastViewModel = dayForecastViewModels.first
            XCTAssertEqual(dayForecastViewModel?.temp, "100.01°")
        }
    }
    
    func test_fetchForecastViewModel_createsDayForecastViewModelsWithCorrectMaxTemp_only2Decimals() {
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            let dayForecastViewModel = dayForecastViewModels.first
            XCTAssertEqual(dayForecastViewModel?.maxTemp, "110.05°")
        }
    }
    
    func test_fetchForecastViewModel_createsDayForecastViewModelsWithCorrectMinTemp_addsDecimals() {
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            let dayForecastViewModel = dayForecastViewModels.first
            XCTAssertEqual(dayForecastViewModel?.minTemp, "100.00°")
        }
    }
    
    func test_fetchForecastViewModel_createsDayForecastViewModelsWithCorrectHumidity() {
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            let dayForecastViewModel = dayForecastViewModels.first
            XCTAssertEqual(dayForecastViewModel?.humidity, "12%")
        }
    }
    
    func test_fetchForecastViewModel_createsDayForecastViewModelsWithCorrectWeekday() {
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            let dayForecastViewModel = dayForecastViewModels.first
            XCTAssertEqual(dayForecastViewModel?.weekDay, "Tue")
        }
    }
    
    func test_fetchForecastViewModel_createsDayForecastViewModelsWithIconCorrectly() {
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            let dayForecastViewModel = dayForecastViewModels.first
            XCTAssertEqual(dayForecastViewModel?.icon, UIImage(named: "01"))
        }
    }
    
    func test_fetchForecastViewModel_createsDayForecastViewModelsWithNoIconCorrectly() {
        let dayForecast = DayForecast(temp: 100.01, maxTemp: 110.053, minTemp: 100, humidity: 12, date: Date(timeIntervalSince1970: 381499523), icon: "")
        let mockCityForecast = CityForecast(cityName: "Madrid", countryName: "Spain", weekForecast: [dayForecast])
        stubForecastInteractor.mockCityForecast = mockCityForecast
        
        self.forecastPresenter.fetchForecastViewModel { (cityForecastViewModel, dayForecastViewModels) in
            let dayForecastViewModel = dayForecastViewModels.first
            XCTAssertNil(dayForecastViewModel?.icon)
        }
    }
}
