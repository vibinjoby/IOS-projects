//
//  CurrencyCalculator.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-09.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import Foundation

class CountryCodes {
    var currencies : [String:String]?
}
// spare key --> 2d4172ca703e3d852fab
//https://free.currconv.com/api/v7/convert?q=CAD_INR&compact=ultra&apiKey=1ecfd3ec23a4d70e87b6
class CurrencyCalculator {
    func getCurrencyValue(completionHandler: @escaping (_ completion: String) -> (),_ baseCurrency:String, _ targetCurrency:String) {
        if let url = URL(string: "https://free.currconv.com/api/v7/convert?q=\(baseCurrency)_\(targetCurrency)&compact=ultra&apiKey=1ecfd3ec23a4d70e87b6") {
            print("\(url)")
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let _ = error {
                    completionHandler("error")
                } else if let data = data {
                    if let jsonString = String(data: data, encoding: .utf8) {
                        if !jsonString.isEmpty {
                            var jsonStr = jsonString.split(separator: ":")[1]
                            jsonStr.removeLast()
                            completionHandler(String(jsonStr))
                        }
                    }
                }
            }.resume()
        }
    }
    //https://currencyapi.net/api/v1/currencies?key=demo
    func getCountryIsoCodes(completionHandler: @escaping (_ completion: String) -> ()) {
        
    }
}

