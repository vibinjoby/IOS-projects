//
//  CurrencyCalculator.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-09.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class CountryCodes {
    var currencies : [String:String]?
}
// spare key --> 2d4172ca703e3d852fab , 1ecfd3ec23a4d70e87b6, 70e18e995052541e2c93
// https://free.currconv.com/api/v7/countries?apiKey=1ecfd3ec23a4d70e87b6
// https://free.currconv.com/api/v7/convert?q=CAD_INR&compact=ultra&apiKey=1ecfd3ec23a4d70e87b6
// https://free.currconv.com/api/v7/convert?q=USD_PHP,PHP_USD&compact=ultra&date=[2019-11-01]&endDate=[2019-11-15]&apiKey=1ecfd3ec23a4d70e87b6
class CurrencyApiManager {
    let apiHelper = ApiHelper()
    var baseUrl = "https://free.currconv.com/api/v7/"
    var apiKey = "70e18e995052541e2c93"
    var spareApiKey = "2d4172ca703e3d852fab"
    
    func getCurrencyValue(completionHandler: @escaping (_ completion: CurrencyApiResults) -> ()) {
            let urlStr = "\(baseUrl)countries?apiKey=\(apiKey)"
            guard let url = URL(string: urlStr) else {return}
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let model = try decoder.decode(CurrencyApiResults.self, from: data)
                    completionHandler(model)//Decode JSON Response Data
                } catch let parsingError {
                    print("Error", parsingError)
                }
                
            }
            task.resume()
    }
    
    func getCurrencyHistory(_ baseCurrency:String,_ targetCurrency:String,_ pastDate:String,_ currentDate:String,completionHandler: @escaping (_ completion: CurrencyHistory) -> ()) {
            let urlStr = "https://free.currconv.com/api/v7/convert?q=\(baseCurrency)_\(targetCurrency)&compact=ultra&date=\(pastDate)&endDate=\(currentDate)&apiKey=\(apiKey)"
            
            guard let url = URL(string: urlStr) else {return}
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let convertedVal = try decoder.decode([String:[String:Double]].self, from: data)
                    let parsedOutput = self.apiHelper.parseJSONResponseCurrencyHistory(convertedVal)
                    completionHandler(parsedOutput)
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
    }
    
    func convertCurrency(_ baseCurrency:String,_ targetCurrency:String, completionHandler: @escaping (_ completion: String) -> ()) {
            let urlStr = "\(baseUrl)convert?q=\(baseCurrency)_\(targetCurrency)&compact=ultra&apiKey=\(apiKey)"
            guard let url = URL(string: urlStr) else {return}
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                do {
                    //here dataResponse received from a network request
                    let decoder = JSONDecoder()
                    let convertedVal = try decoder.decode([String:Double].self, from: data)
                    for (_,val) in convertedVal {
                        completionHandler(String(val))
                    }
                } catch let parsingError {
                    print("Error", parsingError)
                }
            }
            task.resume()
    }
    
}

