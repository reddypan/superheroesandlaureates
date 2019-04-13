//
//  SuperheroesViewController.swift
//  SuperheroesAndLaureates
//
//  Created by Pannala,Vishal Reddy on 4/12/19.
//  Copyright © 2019 Pannala,Vishal Reddy. All rights reserved.
//

import UIKit

class SuperheroesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let superHeroesURL: String = "https://www.dropbox.com/s/wpz5yu54yko6e9j/squad.json?dl=1"
    
    @IBOutlet weak var superheroesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSuperheroes()
    }
    
    var members: [Members] = []
    
    func fetchSuperheroes(){
        let urlSession = URLSession.shared
        let url = URL(string: superHeroesURL)
        urlSession.dataTask(with: url!, completionHandler: displaySuperheroes).resume()
    }
    
    func displaySuperheroes(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        do {
            let decoder = JSONDecoder()
            let superheroes = try decoder.decode(Superheroes.self, from: data!)
            members = superheroes.members
            DispatchQueue.main.async {
                self.superheroesTableView.reloadData()
            }
            
        }catch {
            print(error)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "superheroCell", for: indexPath)
        let superhero = members[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "SUPERHEROS"
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return ""
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 200
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
