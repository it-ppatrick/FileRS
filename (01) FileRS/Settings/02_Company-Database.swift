//
//  02_Company-Database.swift
//  (01) FileRS
//
//  Created by Daniel Petrean on 13.07.25.
//

import SwiftUI

// This class will be our app's "database" for companies.
// It will hold the list and manage adding new ones.
class CompanyStore: ObservableObject {
    @Published var companies: [Company] = [
        // Let's add some default examples
        Company(name: "Petrean Immo", type: .source),
        Company(name: "Stadtgemeinde Marchtrenk", type: .target),
        Company(name: "Google", type: .both)
    ]

    // A function to add a new company
    func addCompany(name: String, type: CompanyType) {
        let newCompany = Company(name: name, type: type)
        companies.append(newCompany)
    }
    
    // A function to get only source companies
    var sourceCompanies: [Company] {
        companies.filter { $0.type == .source || $0.type == .both }
    }
    
    // A function to get only target companies
    var targetCompanies: [Company] {
        companies.filter { $0.type == .target || $0.type == .both }
    }
}
