//
//  ApiUtils.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-16.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class ApiHelper {
    var baseImgUrl = "https://img.freeflagicons.com/thumb/round_icon/"
    func loadCountryWithImagesFromDisk(_ currencyObj:CurrencyApiResults) -> Bool {
        for (_,countryData) in currencyObj.results {
            //Download the flag image
            if countryData.name != nil && countryData.currencyId != nil {
                do {
                    let countryName = countryData.name!.replacingOccurrences(of: " ", with: "_").lowercased()
                    
                    let imageFile = try loadImagesFromLocal(fileName: "\(countryName).png")
                    if imageFile != nil {
                        flagImgModel.append(FlagImageDataModel(countryData.alpha3!,imageFile!))
                        dataModel.append(countryData)
                        filteredCountryArr.append(countryData.currencyName!)
                    }
                } catch {
                    return false
                }
            }
        }
        dataModel = dataModel.sorted(by: sorterForCountryName )
        return true
    }
    
    //Save the images to the local folder
    func downloadImages() {
        for (_,countryData) in apiResultObj!.results {
            //Download the flag image
            if countryData.name != nil {
                let countryName = countryData.name!.replacingOccurrences(of: " ", with: "_").lowercased()
                let flagImgUrl = URL(string: "\(baseImgUrl)\(countryName)/\(countryName)_64.png")
                if flagImgUrl != nil {
                    let data = try? Data(contentsOf: flagImgUrl!)
                    
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        if let data = image?.pngData() {
                            let filename = getDocumentsDirectory().appendingPathComponent("\(countryName).png")
                            try? data.write(to: filename)
                        }
                    }
                }
            }
        }
    }
    
    func parseJSONResponseCurrencyHistory(_ responseOutput:[String:[String:Double]]) -> CurrencyHistory {
        var currencyHistoryObj = CurrencyHistory()
        for (key,value) in responseOutput {
            currencyHistoryObj.currencyId = key
            currencyHistoryObj.historyDateWithRate = value
        }
        return currencyHistoryObj
    }
    
    //Function to load the images from the local folder
    func loadImagesFromLocal(fileName: String) throws -> UIImage? {
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
    func loadBaseTargetImages(_ countryNamesObj:[String]) -> (UIImage?,UIImage?) {
        var baseImage:UIImage?
        var targetImage:UIImage?
        do {
            for countryName in countryNamesObj {
                let imageFile = try loadImagesFromLocal(fileName: "\(countryName).png")
                if imageFile == nil {
                    let flagImgUrl = URL(string: "\(baseImgUrl)\(countryName)/\(countryName)_64.png")
                    let data = try? Data(contentsOf: flagImgUrl!)
                    
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        if let data = image?.pngData() {
                            let filename = getDocumentsDirectory().appendingPathComponent("\(countryName).png")
                            try? data.write(to: filename)
                        }
                    }
                }
                if countryName == "india" {
                   baseImage = imageFile
                } else {
                    targetImage = imageFile
                }
            }
            
        } catch {
            print("error while loading the base and target images")
        }
        return (baseImage,targetImage)
        
    }
    
    func sorterForCountryName(this:CountryDataModel, that:CountryDataModel) -> Bool {
        return this.name! < that.name!
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getCurrentTime() -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_CA_POSIX")
        formatter.dateFormat = "'Last updated: ' MMMM dd, yyyy 'at' h:mm a"
        formatter.amSymbol = "AM"
        formatter.pmSymbol = "PM"

        return formatter.string(from: Date())
    }
    
    func getCustomizedHistoryDates(_ strDate:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'"
        let date = dateFormatter.date(from: strDate)
        
        dateFormatter.locale = Locale(identifier: "en_CA_POSIX")
        dateFormatter.dateFormat = "'On ' MMMM dd, yyyy ' it was '"
        
        return dateFormatter.string(from: date!)
    }
}


