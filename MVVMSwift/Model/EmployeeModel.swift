//
//  EmployeeModel.swift
//  MVVMSwift
//
//  Created by Venkata Sudhakar Reddy on 06/03/25.
//

import Foundation

typealias Employees = [EmployeeModel]

struct EmployeeModel: Codable {
    let id: String
    let name: String
    let salary: String
    let age: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
    }
}
