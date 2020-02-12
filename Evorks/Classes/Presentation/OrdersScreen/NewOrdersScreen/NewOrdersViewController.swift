//
//  NewOrdersViewController.swift
//  Evorks
//
//  Created by Anton Samonin on 2/11/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift

final class NewOrdersViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        addSubviews()
        bind()
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func bind() {
        
    }

}
