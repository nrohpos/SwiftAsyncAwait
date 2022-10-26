//
//  ViewController.swift
//  SwiftAsyncAwait
//
//  Created by Papaya on 18/10/2022.
//

import UIKit

class ViewController: UIViewController {
   
    let tableView : UITableView = {
        let tableView = UITableView()
      
        return tableView
    }()

    let viewModel = ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        ui : do {
            setConstraint()
        }
        
        tableView : do {
            tableView.dataSource = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        }
        
        viewModel.bindData(completion: { isSuccess, error in
            if !isSuccess {
                print(error ?? "this is an error")
            }
            self.tableView.reloadData()
        })
    }
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.itemList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(String(describing: viewModel.itemList[indexPath.row].id))"
        return cell
    }
}

extension ViewController {
    func setConstraint() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor,constant: 48).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
