//
//  Model.swift
//  JSON
//
//  Created by Guzel on 01.11.2022.
//

import Foundation

struct Model: Decodable {
    let company: Company
}

struct Company: Decodable {
    let name: String
    let employees: [Employee]
}

struct Employee: Decodable {
    let name: String
    let phone_number: String
    let skills: [String]
}
