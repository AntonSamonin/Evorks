//
//  MenuBar.swift
//  Evorks
//
//  Created by Anton Samonin on 2/10/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum MenuItemType {
    case first(String)
    case second(String)
    case third(String)
    case forth(String)
}

class MenuBar: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MenuBarCell.self, forCellWithReuseIdentifier: "menuBarCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        return collectionView
    }()
    
    private var menuItems: [MenuItemType]
    private let disposeBag = DisposeBag()
    var currentItem: BehaviorRelay<MenuItemType>
    
    init(menuItems: [MenuItemType]) {
        self.menuItems = menuItems
        currentItem = BehaviorRelay<MenuItemType>(value: menuItems[0])
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews()
        collectionView.delegate = self
        collectionView.dataSource = self
        let selectedIndexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: selectedIndexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition())
    }
    
    private func addSubviews() {
        addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}

extension MenuBar: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "menuBarCell", for: indexPath) as? MenuBarCell else {return UICollectionViewCell()}
        cell.bind(itemType: menuItems[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentItem.accept(menuItems[indexPath.row])
    }
}

