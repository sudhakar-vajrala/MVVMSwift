//
//  EmployeeViewController.swift
//  MVVMSwift
//
//  Created by Venkata Sudhakar Reddy on 04/03/25.
//

import UIKit

class EmployeeViewController: UIViewController {
    
    @IBOutlet weak var empTableView: UITableView!
    lazy var viewModel = {
        EmployeeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //navigation title
        self.title = "MVVMSwift"
        
        initView()
        initViewModel()
    }

    func initView() {
        //empTableView.backgroundColor = UIColor(#colorLiteral(red: 0.6196078431, green: 0.1098039216, blue: 0.2509803922, alpha: 1))
        empTableView.separatorColor = .white
        empTableView.separatorStyle = .singleLine
        empTableView.tableFooterView = UIView()
        empTableView.allowsSelection = false

        empTableView.register(EmployeeCell.nib, forCellReuseIdentifier: EmployeeCell.identifier)
    }

    func initViewModel() {
        // Get employees data
        viewModel.getEmployees()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.empTableView.reloadData()
            }
        }
    }
    
}

// MARK: - UITableViewDataSource

extension EmployeeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.employeeCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmployeeCell.identifier, for: indexPath) as? EmployeeCell else { fatalError("xib does not exists") }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}
