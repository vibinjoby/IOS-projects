//
//  ShowHistoryController.swift
//  Calculator
//
//  Created by vibin joby on 2019-11-03.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

protocol ShowHistoryControllerDelegate {
    func clear()
}

class ShowHistoryController: UITableViewController {
    var historyDataArr = [String]()
    var delegate: ShowHistoryControllerDelegate!
    
    func sendHistoryData(_ historyArr: [String]) {
        historyDataArr = historyArr
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyDataArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        for index in 0..<historyDataArr.count {
            if indexPath.row == index {
                label.text = historyDataArr[index]
            }
        }
        return cell
    }
    
    @IBAction func close() {
        navigationController?.popViewController(animated: true)
    }
    //Action method for clear button
    //Clear the history array data
    @IBAction func clear() {
        delegate.clear()
        historyDataArr = []
        tableView.reloadData()
    }
}
