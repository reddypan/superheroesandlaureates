//
//  Superheroes.swift
//  SuperheroesAndLaureates
//
//  Created by Pannala,Vishal Reddy on 4/12/19.
//  Copyright © 2019 Pannala,Vishal Reddy. All rights reserved.
//

import Foundation

struct Superheroes: Codable {
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


struct Laureates {
    var firstname : String
    var surname: String
    var born: String
    var died: String
}
