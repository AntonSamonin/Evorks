//
//  OrdersViewController.swift
//  Evorks
//
//  Created by Anton Samonin on 2/9/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class OrdersViewController: UIViewController {
    
    private lazy var newOrdersVC = NewOrdersViewController()
    private lazy var myOrdersVC = MyOrdersViewController()
    private lazy var inWorkVC = InWorkViewController()
    private lazy var doneOrders = DoneOrdersViewController()
    
    private lazy var menuBar: MenuBar = {
        let menuBar = MenuBar(menuItems: [.first("new_orders".localized), .second("my_orders".localized), .third("in_work".localized), .forth("done_orders".localized)])
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    
    private lazy var containerView: UIView = {
        let tableView = UIView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let disposeBag = DisposeBag()
    private var previousItem: MenuItemType?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = #colorLiteral(red: 0.9529411765, green: 0.9529411765, blue: 0.9529411765, alpha: 1)
        setupNavigationBar()
        addSubviews()
        bind()
    }

    private func setupNavigationBar() {
        navigationItem.title = "orders".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font.Montserrat.regular(size: 20)]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
    private func addSubviews() {
        view.addSubview(menuBar)
        view.addSubview(containerView)
        
        menuBar.topAnchor.constraint(equalTo: view.topAnchor, constant: 75).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        containerView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func bind() {
        menuBar.currentItem
            .subscribe(onNext: { [weak self] item in
                self?.changeVC(at: item)
            })
            .disposed(by: disposeBag)
    }
    
    private func changeVC(at selectedItem: MenuItemType) {
        if let previousTab = self.previousItem {
            let previousVC = vc(at: previousTab)
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
        
        previousItem = selectedItem
        
        let selectedVC = vc(at: selectedItem)
        addChild(selectedVC)
        selectedVC.view.frame = containerView.bounds
        containerView.addSubview(selectedVC.view)
        selectedVC.willMove(toParent: self)
    }
    
    private func vc(at item: MenuItemType) -> UIViewController {
        switch item  {
        case .first(_):
            return newOrdersVC
        case .second(_):
            return myOrdersVC
        case .third(_):
            return inWorkVC
        case .forth(_):
            return doneOrders
        }
    }
}
