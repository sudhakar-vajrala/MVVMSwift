//
//  EmployeeViewModel.swift
//  MVVMSwift
//
//  Created by Venkata Sudhakar Reddy on 06/03/25.
//

import Foundation

struct EmployeeCellViewModel {
    var id: String
    var name: String
    var salary: String
    var age: String
}

class EmployeeViewModel: NSObject {
    
    private var employeeService: EmployeesService
    var employees = Employees()
    var reloadTableView: (() -> Void)?
    var employeeCellViewModels = [EmployeeCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(employeeService:EmployeesService = EmployeesService()) {
        self.employeeService = employeeService
    }
    
    func getEmployees() {
        employeeService.getEmployees { success, model, error in
            if success, let employees = model {
                self.fetchData(employees: employees)
            } else {
                print(error!)
            }
        }
    }
    
    func fetchData(employees: Employees) {
        self.employees = employees // Cache
        var vms = [EmployeeCellViewModel]()
        for employee in employees {
            vms.append(createCellModel(employee: employee))
        }
        employeeCellViewModels = vms
    }
    
    func createCellModel(employee: EmployeeModel) -> EmployeeCellViewModel {
        let id = "\(employee.id)"
        let name = employee.name
        let salary = "$ " + employee.salary
        let age = employee.age
        
        return EmployeeCellViewModel(id: id, name: name, salary: salary, age: age)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> EmployeeCellViewModel {
        return employeeCellViewModels[indexPath.row]
    }
    
}
