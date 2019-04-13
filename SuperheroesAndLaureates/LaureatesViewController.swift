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
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBOutlet weak var laureatesTableView: UITableView!
    var laureatesURL = "https://www.dropbox.com/s/7dhdrygnd4khgj2/squad.json?dl=1"
    

    var laureatesArray: [Laureates] = [Laureates(firstname: "Hello", surname: "Hello", born: "Hello", died: "Hello")]
    func fetchLaureates(){
        let urlSession = URLSession.shared
        let url = URL(string: laureatesURL)
        urlSession.dataTask(with: url!, completionHandler: displayLaureates).resume()
    }

    func displayLaureates(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        var laureates:[[String:Any]]!
        var firstName: String
        var surname: String
        var born: String
        var died: String
        do {
            try laureates = JSONSerialization.jsonObject(with: data!, options: .allowFragments)  as?  [[String:Any]]
            for i in 0..<laureates!.count {
                if i != 461 && i != 470 && i != 475 {
                try firstName = (laureates![i]["firstname"] as? String)!
                try surname = (laureates![i]["surname"] as? String)!
                try born = (laureates![i]["born"] as? String)!
                try died = (laureates![i]["died"] as? String)!
                self.laureatesArray.append(Laureates(firstname: firstName, surname: surname, born: born, died: died))
            }
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
        cell.textLabel?.text = laureate.firstname
        return cell
    }
    
}

