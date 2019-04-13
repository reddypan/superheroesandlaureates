//
//  LaureatesTableViewController.swift
//  SuperheroesAndLaureates
//
//  Created by student on 4/13/19.
//  Copyright © 2019 Pannala,Vishal Reddy. All rights reserved.
//

import UIKit

class LaureatesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Laureates.shared.fetchLaureates()
        NotificationCenter.default.addObserver(self, selector:#selector(laureatesDelivered),name: NSNotification.Name("Laureates data"), object:nil)
    }
    
    @objc func laureatesDelivered(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Laureates.shared.laureates.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "laureatesCell", for: indexPath)
        let laureate = Laureates.shared.laureates[indexPath.row]
        let titleLBL = cell.viewWithTag(100) as! UILabel
        let birthyearLBL = cell.viewWithTag(200) as! UILabel
        titleLBL.text = "\(laureate.firstname!) \(laureate.surname!)"
        birthyearLBL.text = "\(laureate.born!) - \(laureate.died!)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LAUREATES"
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

}
