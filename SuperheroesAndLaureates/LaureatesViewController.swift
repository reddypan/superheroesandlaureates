//
//  SecondViewController.swift
//  SuperheroesAndLaureates
//
//  Created by Pannala,Vishal Reddy on 4/12/19.
//  Copyright © 2019 Pannala,Vishal Reddy. All rights reserved.
//

import UIKit

class LaureatesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLaureates()
    }
    
    @IBOutlet weak var laureatesTableView: UITableView!
    var laureatesURL = "https://www.dropbox.com/s/7dhdrygnd4khgj2/laureates.json?dl=1"
    

    var laureatesArray: [Laureates] = []
    func fetchLaureates(){
        let urlSession = URLSession.shared
        let url = URL(string: laureatesURL)
        urlSession.dataTask(with: url!, completionHandler: displayLaureates).resume()
    }

    func displayLaureates(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        var laureates:[[String:Any]]!
        var firstName: String?
        var surname: String?
        var born: String?
        var died: String?
        do {
            try laureates = JSONSerialization.jsonObject(with: data!, options: .allowFragments)  as?  [[String:Any]]
            for i in 0..<laureates!.count {
                firstName = ((laureates![i]["firstname"] as? String))
                surname = ((laureates![i]["surname"] as? String))
                born = (laureates![i]["born"] as? String)
                died = (laureates![i]["died"] as? String)
                self.laureatesArray.append(Laureates(firstname: firstName, surname: surname, born: born, died: died))
            }
            DispatchQueue.main.async {
                self.laureatesTableView.reloadData()
            }
        } catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laureatesArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "laureatesCell", for: indexPath)
        let laureate = laureatesArray[indexPath.row]
        let titleLBL = cell.viewWithTag(100) as! UILabel
        let birthyearLBL = cell.viewWithTag(200) as! UILabel
        titleLBL.text = "\(laureate.firstname!) \(laureate.surname!)"
        birthyearLBL.text = "\(laureate.born!) - \(laureate.died!)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "LAUREATES"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

