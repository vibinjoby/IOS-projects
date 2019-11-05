//
//  ShowHistoryController.swift
//  Calculator
//
//  Created by vibin joby on 2019-11-03.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import UIKit

class ShowHistoryController: UIViewController, UITableViewDelegate,  UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ViewController.historyArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        let label = cell.viewWithTag(1) as! UILabel
        for index in 0..<ViewController.historyArr.count {
            if indexPath.row == index {
                label.text = ViewController.historyArr[index]
            }
        }
        return cell
    }
    
    @IBAction func close() {
      dismiss(animated: true, completion: nil)
    }    
}
