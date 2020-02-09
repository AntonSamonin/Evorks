//
//  TabView.swift
//  Evorks
//
//  Created by Anton Samonin on 2/9/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TabView: UIView {
    enum Tab {
        case orders, cabinet, help
    }
    
    private lazy var ordersTabItem: TabItemView = {
        let item = TabItemView(selectedImage: UIImage(named: "orders_selected")!, unSelectedImage: UIImage(named: "orders")!)
        item.titleLabel.text = "orders".localized
        return item
    }()
    
    private lazy var cabinetTabItem: TabItemView = {
        let item = TabItemView(selectedImage: UIImage(named: "cabinet_selected")!, unSelectedImage: UIImage(named: "cabinet")!)
        item.titleLabel.text = "cabinet".localized
        return item
    }()
    
    private lazy var helpTabItem: TabItemView = {
        let item = TabItemView(selectedImage: UIImage(named: "help_selected")!, unSelectedImage: UIImage(named: "help")!)
        item.titleLabel.text = "help".localized
        return item
    }()
    
    let currentTab = BehaviorRelay<Tab>(value: .orders)
    
    private let disposeBag = DisposeBag()
    
    init() {
        super.init(frame: .zero)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.368627451, blue: 0.8901960784, alpha: 1)
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        bind()
    }
    
    private func addSubviews() {
        addSubview(ordersTabItem)
        addSubview(cabinetTabItem)
        addSubview(helpTabItem)
        
        ordersTabItem.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        ordersTabItem.topAnchor.constraint(equalTo: topAnchor).isActive = true
        ordersTabItem.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        ordersTabItem.widthAnchor.constraint(equalTo: cabinetTabItem.widthAnchor).isActive = true
        
        cabinetTabItem.leadingAnchor.constraint(equalTo: ordersTabItem.trailingAnchor).isActive = true
        cabinetTabItem.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cabinetTabItem.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cabinetTabItem.widthAnchor.constraint(equalTo: helpTabItem.widthAnchor).isActive = true
        
        helpTabItem.leadingAnchor.constraint(equalTo: cabinetTabItem.trailingAnchor).isActive = true
        helpTabItem.topAnchor.constraint(equalTo: topAnchor).isActive = true
        helpTabItem.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        helpTabItem.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func bind() {
        currentTab
            .subscribe(onNext: { [weak self] tab in
                self?.ordersTabItem.isSelected = tab == .orders
                self?.cabinetTabItem.isSelected = tab == .cabinet
                self?.helpTabItem.isSelected = tab == .help
            })
            .disposed(by: disposeBag)
        
        Observable.merge(ordersTabItem.didTap.map {Tab.orders},
                         cabinetTabItem.didTap.map {Tab.cabinet},
                         helpTabItem.didTap.map {Tab.help})
            .bind(to: currentTab)
            .disposed(by: disposeBag)
    }
}
