//
//  SuperheroesTableViewController.swift
//  SuperheroesAndLaureates
//
//  Created by student on 4/13/19.
//  Copyright © 2019 Pannala,Vishal Reddy. All rights reserved.
//

import UIKit

class SuperheroesTableViewController: UITableViewController {

    let superHeroesURL: String = "https://www.dropbox.com/s/wpz5yu54yko6e9j/squad.json?dl=1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Superheroes.shared.fetchSuperheroes()
        NotificationCenter.default.addObserver(self, selector:#selector(superHeroesDelivered),name: NSNotification.Name("Superheroes data"), object:nil)
    }
    
    @objc func superHeroesDelivered(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Superheroes.shared.members.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superheroCell", for: indexPath)
        let superhero = Superheroes.shared.members[indexPath.row]
        cell.textLabel?.text = "\(superhero.name) (aka: \(superhero.secretIdentity))"
        var subTitleText = ""
        for i in 0..<superhero.powers.count{
            if i == superhero.powers.count - 1  {
                subTitleText += superhero.powers[i]
            }else{
                subTitleText += "\(superhero.powers[i]), "
            }
        }
        cell.detailTextLabel?.text = subTitleText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SUPERHEROS"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }


}
