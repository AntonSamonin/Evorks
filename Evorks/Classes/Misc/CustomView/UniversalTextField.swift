//
//  UniversalTextField.swift
//  Evorks
//
//  Created by Anton Samonin on 2/8/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class UniversalAuthTextField: UIView {
    
    private let disposeBag = DisposeBag()
    
    lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.textColor = #colorLiteral(red: 0.7568627451, green: 0.8431372549, blue: 1, alpha: 1)
        headerLabel.font = Font.Montserrat.light(size: 15)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        return headerLabel
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.textColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 17)
        textField.isSecureTextEntry = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.tintColor = UIColor.gray
        textField.layer.cornerRadius = 3
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        addSubviews()
        bind()
    }
    
    private func addSubviews() {
        
        addSubview(headerLabel)
        addSubview(textField)
        
        headerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        headerLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        headerLabel.heightAnchor.constraint(equalToConstant: 23).isActive = true
        
        textField.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 8).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func bind() {
        
    }
    
}
