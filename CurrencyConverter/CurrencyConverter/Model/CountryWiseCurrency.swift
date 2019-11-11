//
//  CountryWiseCurrency.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-10.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import Foundation

class CountryWiseCurrency {
    var country:String
    var currency:String
    var flagImage:String
     
    init(_ country:String,_ currency:String,_ flagImage:String) {
        self.country = country
        self.currency = currency
        self.flagImage = flagImage
    }
}
