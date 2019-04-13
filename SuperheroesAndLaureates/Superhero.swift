//
//  Superheroes.swift
//  SuperheroesAndLaureates
//
//  Created by Pannala,Vishal Reddy on 4/12/19.
//  Copyright © 2019 Pannala,Vishal Reddy. All rights reserved.
//

import Foundation

struct Superhero: Codable {
    var squadName: String
    var homeTown: String
    var formed: Int
    var secretBase: String
    var active: Bool
    var members: [Members]
}

struct Members: Codable {
    var name: String
    var age: Int
    var secretIdentity: String
    var powers: [String]
}

class Superheroes {
    
    static var shared = Superheroes()
    
    var members: [Members]
    
    init(){
        members = []
    }
    
    let superHeroesURL: String = "https://www.dropbox.com/s/wpz5yu54yko6e9j/squad.json?dl=1"
    
    func fetchSuperheroes(){
        let urlSession = URLSession.shared
        let url = URL(string: superHeroesURL)
        urlSession.dataTask(with: url!, completionHandler: displaySuperheroes).resume()
    }
    
    func displaySuperheroes(data:Data?, urlResponse:URLResponse?, error:Error?)->Void {
        do {
            let decoder = JSONDecoder()
            let superheroes = try decoder.decode(Superhero.self, from: data!)
            self.members = superheroes.members
            NotificationCenter.default.post(name: NSNotification.Name("Superheroes data"), object: nil)
        }catch {
            print(error)
        }
    }
}
