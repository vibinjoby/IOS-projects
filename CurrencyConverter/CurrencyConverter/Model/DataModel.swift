//
//  DataModel.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-15.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

/* Api Data model to store the currency code, currency name and the symbol from the api results */
struct CurrencyApiResults : Codable {
    var results = [String:CountryDataModel]()
}

/* Api data model to store the country details along with the currency iso code */
struct CountryDataModel : Codable {
    var alpha3:String?
    var currencyId:String?
    var currencyName:String?
    var currencySymbol:String?
    //Country name
    var name:String?
}

/* Api data model for storing images using currency id as the key */
struct FlagImageDataModel {
    var currencyId:String
    var flagImage:UIImage
     
    init(_ currencyId:String,_ flagImage:UIImage) {
        self.currencyId = currencyId
        self.flagImage = flagImage
    }
}

struct CurrencyHistory {
    var historyDateWithRate:[String:Double]?
    var currencyId:String?
}



