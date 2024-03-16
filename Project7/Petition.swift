//
//  Petition.swift
//  Project7
//
//  Created by Burak Güzey on 16.03.2024.
//

import Foundation

struct Petition: Codable {
    
    var title: String
    var body: String
    var signatureCount: Int
    
}

struct Petitions: Codable {
    var results: [Petition]
}
