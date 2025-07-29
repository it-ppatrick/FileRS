//
//  01_Company-definition.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import Foundation

// Defines the structure for a single company
struct Company: Identifiable, Codable {
    var id = UUID() // A unique ID for each company
    var name: String
    var type: CompanyType
}

// Defines the possible types for a company
enum CompanyType: String, CaseIterable, Codable {
    case source = "Source"
    case target = "Target"
    case both = "Source & Target"
}
