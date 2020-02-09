//
//  PhoneTextField.swift
//  Evorks
//
//  Created by Anton Samonin on 2/9/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import TLCustomMask

class PhoneTextField: UIView {
    
    var phoneNumber: BehaviorRelay<String>!
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
        textField.leftView = leftPaddingView
        textField.leftViewMode = UITextField.ViewMode.always
        textField.textColor = .black
        textField.font = Font.Montserrat.regular(size: 18)
        textField.isSecureTextEntry = false
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.tintColor = UIColor.gray
        textField.layer.cornerRadius = 3
        textField.backgroundColor = .white
        textField.text = "+7"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let disposeBag = DisposeBag()
    private let customMask = TLCustomMask()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    private func configure() {
        phoneNumber = BehaviorRelay(value: customMask.cleanText)
        addSubviews()
        bind()
        textField.delegate = self
    }
    
    private func addSubviews() {
        addSubview(textField)
        
        textField.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    private func bind() {}
}

extension PhoneTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        customMask.formattingPattern = "($$$) $$$-$$-$$"
        textField.text = customMask.formatStringWithRange(range: range, string: string)
        phoneNumber.accept(customMask.cleanText)
        if textField.text?.isEmpty == false { textField.text = "+7 \(textField.text ?? "")" }
        if textField.text?.isEmpty == true { textField.text = "+7" }
        
        return false
    }
}

