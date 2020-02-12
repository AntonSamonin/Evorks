//
//  MenuBarCell.swift
//  Evorks
//
//  Created by Anton Samonin on 2/10/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MenuBarCell: UICollectionViewCell {
    
    struct Constansts {
        static let selectedBackgroundColor = #colorLiteral(red: 0.07843137255, green: 0.368627451, blue: 0.8901960784, alpha: 1)
        static let unselectedBackGroundColor = UIColor.white
        static let selectedTextColor = UIColor.white
        static let unselectedTextColor = #colorLiteral(red: 0.2196078431, green: 0.2392156863, blue: 0.2745098039, alpha: 1)
        static let unselectedBorderColor = UIColor.gray.withAlphaComponent(0.5)
    }
    
    private lazy var title: UILabel = {
        let title = UILabel()
        title.font = Font.Montserrat.regular(size: 14)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? Constansts.selectedBackgroundColor : Constansts.unselectedBackGroundColor
            title.textColor = isSelected ? Constansts.selectedTextColor : Constansts.unselectedTextColor
            borderColor = isSelected ? UIColor.clear : Constansts.unselectedBorderColor
            borderWidth = isSelected ? 0 : 1
        }
    }
    
    private func configure() {
        addSubviews()
        backgroundColor = Constansts.unselectedBackGroundColor
        title.textColor = Constansts.unselectedTextColor
        borderColor = Constansts.unselectedBorderColor
        borderWidth = 1
        cornerRadius = 2
    }
    
    private func addSubviews() {
        addSubview(container)
        container.addSubview(title)
        
        container.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        container.topAnchor.constraint(equalTo: topAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        container.heightAnchor.constraint(equalToConstant: 42).isActive = true
        
        title.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 10).isActive = true
        title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -10).isActive = true
    }
    
    func bind(itemType: MenuItemType) {
        switch itemType {
        case .first(let type):
            title.text = type
        case .second(let type):
            title.text = type
        case .third(let type):
            title.text = type
        case .forth(let type):
            title.text = type
        }
    }
}
