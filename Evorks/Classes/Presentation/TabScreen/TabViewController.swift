//
//  TabViewController.swift
//  Evorks
//
//  Created by Anton Samonin on 2/9/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

final class TabViewController: UIViewController {
    
    private lazy var ordersViewController = UINavigationController(rootViewController: OrdersViewController())
    private lazy var cabinetViewController = UINavigationController(rootViewController: CabinetViewController())
    private lazy var helpViewController = UINavigationController(rootViewController: HelpViewController())
    
    private lazy var tabBar: TabView = {
        let view = TabView()
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let disposeBag = DisposeBag()
    private var previousTab: TabView.Tab?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        bind()
    }
    
    private func addSubviews() {
        view.addSubview(tabBar)
        view.addSubview(containerView)
        
        tabBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tabBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tabBar.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tabBar.heightAnchor.constraint(equalToConstant: 85).isActive = true
        
        containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor).isActive = true
    }
    
    private func bind() {
        tabBar
            .currentTab
            .subscribe(onNext: { [weak self] tab in
                self?.changeVC(at: tab)
            })
            .disposed(by: disposeBag)
    }
    
    private func changeVC(at selectedTab: TabView.Tab) {
        if let previousTab = self.previousTab {
            let previousVC = vc(at: previousTab)
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
        }
        
        previousTab = selectedTab
        
        let selectedVC = vc(at: selectedTab)
        addChild(selectedVC)
        selectedVC.view.frame = containerView.bounds
        containerView.addSubview(selectedVC.view)
        selectedVC.willMove(toParent: self)
    }
    
    private func vc(at tab: TabView.Tab) -> UIViewController {
        switch tab {
        case .orders:
            return ordersViewController
        case .cabinet:
            return cabinetViewController
        case .help:
            return helpViewController
        }
    }
}
