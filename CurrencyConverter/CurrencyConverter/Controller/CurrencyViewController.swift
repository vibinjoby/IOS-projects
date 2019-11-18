//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-10.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

protocol CurrencyDelegate:class {
    func setBaseChangeCurrency(_ countryObj:CountryDataModel)
    func setTargetChangeCurrency(_ countryObj:CountryDataModel)
}
class CurrencyViewController: UIViewController , UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    weak var delegate:CurrencyDelegate?
    let apiUtils = ApiHelper()
    var isTargetCurrency:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func colorForIndex(index: Int) -> UIColor {
        let itemCount = dataModel.count - 1
        let color = (CGFloat(index) / CGFloat(itemCount)) * 0.6
        return UIColor(red: 0.80, green: color, blue: 0.0, alpha: 1.0)
    }
    
    
    private func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = colorForIndex(index: indexPath.row)
        } else {
            cell.backgroundColor = UIColor.yellow
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
            },completion: { finished in
                UIView.animate(withDuration: 0.1, animations: {
                    cell.layer.transform = CATransform3DMakeScale(1,1,1)
                })
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        if filteredData.count > indexPath.row {
            let countryObj = filteredData[indexPath.row]
            let label = cell.viewWithTag(1) as! UILabel
            let countryImage = cell.viewWithTag(2) as! UIImageView
            label.text = countryObj.name
            
            let flagImgIndex = flagImgModel.firstIndex { (flagImgDataObj) -> Bool in
                return flagImgDataObj.currencyId == countryObj.alpha3
            }
            
            countryImage.image = flagImgModel[flagImgIndex!].flagImage
            
            if (indexPath.row % 2 == 0) {
                cell.backgroundColor = colorForIndex(index: indexPath.row)
            } else {
                cell.backgroundColor = UIColor.white
            }
        } else {
            return UITableViewCell()
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath) != nil {
            let countryObj = filteredData[indexPath.row]
            if !isTargetCurrency! {
                delegate?.setBaseChangeCurrency(countryObj)
            } else {
                delegate?.setTargetChangeCurrency(countryObj)
            }
            filteredData = dataModel
        }
    }
    // MARK: - Search view data source
    /*
     // When there is no text, filteredData is the same as the original data
     // When user has entered text into the search box
     // Use the filter method to iterate over all items in the data array
     // For each item, return true if the item should be included and false if the
     // item should NOT be included
     */
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = searchText.isEmpty ? dataModel : dataModel.filter { (item: CountryDataModel) -> Bool in
            return item.name?.range(of: searchText, options: .caseInsensitive) != nil
        }
        tableView.reloadData()
    }
}



