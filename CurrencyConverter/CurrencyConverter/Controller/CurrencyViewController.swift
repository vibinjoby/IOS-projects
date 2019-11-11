//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by vibin joby on 2019-11-10.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

protocol CurrencyDelegate:class {
    func setBaseChangeCurrency(_ countryObj:CountryWiseCurrency)
    func setTargetChangeCurrency(_ countryObj:CountryWiseCurrency)
}

class CurrencyJson {
    
}

class CurrencyViewController: UITableViewController {
    
    weak var delegate:CurrencyDelegate?
    var currencyForCountry = [CountryWiseCurrency]()

    override func viewDidLoad() { 
        super.viewDidLoad()
        loadCountryArrayObj()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return currencyForCountry.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "currencyCell", for: indexPath)
        let currencyObj = currencyForCountry[indexPath.row]
        let label = cell.viewWithTag(1) as! UILabel
        let countryImage = cell.viewWithTag(2) as! UIImageView
        label.text = currencyObj.country
        countryImage.image = UIImage(named: currencyObj.flagImage)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath) != nil {
            // Replace everything inside this `if` condition // with the following
            let countryObj = currencyForCountry[indexPath.row]
            delegate?.setBaseChangeCurrency(countryObj)
        }
        
    }
    
    func loadCountryArrayObj() {
        currencyForCountry.append(CountryWiseCurrency("United states Dollar", "USD", "unitedStatesOfAmerica"))
        currencyForCountry.append(CountryWiseCurrency("Indian Rupee", "INR", "india"))
        currencyForCountry.append(CountryWiseCurrency("Canadian Dollar", "CAD", "canada"))
        
        currencyForCountry.append(CountryWiseCurrency("British Pound", "GBP", "united-kingdom"))
        currencyForCountry.append(CountryWiseCurrency("Australian Dollar", "AUD", "australia"))
        currencyForCountry.append(CountryWiseCurrency("Japanese Yen", "JPY", "japan"))
        currencyForCountry.append(CountryWiseCurrency("Chinese Yuan", "CNY", "china"))
        currencyForCountry.append(CountryWiseCurrency("Malaysian Ringgit", "MYR", "malaysia"))
        currencyForCountry.append(CountryWiseCurrency("Singapore Dollar", "SGD", "singapore"))
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
