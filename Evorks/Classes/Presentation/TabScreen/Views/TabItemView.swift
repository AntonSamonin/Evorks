//
//  TabItemView.swift
//  Evorks
//
//  Created by Anton Samonin on 2/9/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TabItemView: UIView {
    struct Constansts {
        static let selectedColor = #colorLiteral(red: 0.9882352941, green: 0.4509803922, blue: 0.4509803922, alpha: 1)
        static let unSelectedColor = UIColor.white
    }
    
    @IBInspectable var selectedImage: UIImage?
    @IBInspectable var unSelectedImage: UIImage?
    
    lazy var iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Font.Montserrat.medium(size: 11)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let didTap = PublishRelay<Void>()
    
    private var selectorHeightConstraint: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    
    init(selectedImage: UIImage, unSelectedImage: UIImage) {
        super.init(frame: .zero)
        
        self.selectedImage = selectedImage
        self.unSelectedImage = unSelectedImage
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configure()
    }
    
    var isSelected: Bool = false {
        didSet {
            iconView.image = isSelected ? selectedImage : unSelectedImage
            titleLabel.textColor = isSelected ? Constansts.selectedColor : Constansts.unSelectedColor
        }
    }
    
    private func configure() {
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubviews()
        bind()
    }
    
    private func addSubviews() {
        addSubview(iconView)
        addSubview(titleLabel)
        
        iconView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 29).isActive = true
        iconView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        iconView.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor).isActive = true
    }
    
    private func bind() {
        let tapGesture = UITapGestureRecognizer()
        addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .map { _ in Void() }
            .bind(to: didTap)
            .disposed(by: disposeBag)
    }
}
