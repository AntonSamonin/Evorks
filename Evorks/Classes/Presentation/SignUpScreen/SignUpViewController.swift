//
//  SignUpViewController.swift
//  Evorks
//
//  Created by Anton Samonin on 2/9/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    private lazy var titleLable: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.numberOfLines = 0
        title.font = Font.Montserrat.medium(size: 20)
        title.text = "enter_your_number".localized
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var registrationInfoLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.numberOfLines = 0
        title.font = Font.Montserrat.regular(size: 15)
        title.text = "registration_info".localized
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var phoneNumberTextField: PhoneTextField = {
        let phoneTextField = PhoneTextField()
        phoneTextField.textField.keyboardType = .numberPad
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        return phoneTextField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        let attr = TextAttributes()
            .font(Font.Montserrat.bold(size: 18))
            .textColor(#colorLiteral(red: 0.0431372549, green: 0.5019607843, blue: 0.8784313725, alpha: 1))
            .textAlignment(.center)
        button.setAttributedTitle("continue".localized.attributed(with: attr), for: .normal)
        button.cornerRadius = 32
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var toSignInButton: UIButton = {
        let button = UIButton()
        let attr = TextAttributes()
            .font(Font.Montserrat.regular(size: 16))
            .textColor(.white)
            .textAlignment(.center)
            .underlineColor(UIColor.white)
            .underlineStyle(.single)
        button.setAttributedTitle("authorization".localized.attributed(with: attr), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let disposeBag = DisposeBag()
    private let viewModel = SignUpViewModel()
    private var titleLabelTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.368627451, blue: 0.8901960784, alpha: 1)
        addSubviews()
        bind()
        addActions()
        whenKeyboard()
    }
    
    private func addSubviews() {
        view.addSubview(titleLable)
        view.addSubview(registrationInfoLabel)
        view.addSubview(phoneNumberTextField)
        view.addSubview(continueButton)
        view.addSubview(toSignInButton)
        
        titleLabelTopConstraint = titleLable.topAnchor.constraint(equalTo: view.topAnchor, constant: 170)
        titleLabelTopConstraint.isActive = true
        titleLable.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        phoneNumberTextField.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 40).isActive = true
        phoneNumberTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        phoneNumberTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        phoneNumberTextField.heightAnchor.constraint(equalToConstant: 63).isActive = true
        
        registrationInfoLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 27).isActive = true
        registrationInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        registrationInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        continueButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        
        toSignInButton.topAnchor.constraint(equalTo: view.topAnchor, constant: SizeUtils.value(largeDevice: 60, smallDevice: 30)).isActive = true
        toSignInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func bind() {
        toSignInButton.rx.tap
            .bind {
                var mainWindow: UIWindow? {
                    if #available(iOS 13.0, *) {
                        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                            return windowScene.windows.first
                        }
                    }
                    return UIApplication.shared.keyWindow
                }
                mainWindow?.rootViewController = SignInViewController()
        }
        .disposed(by: disposeBag)
        
        phoneNumberTextField.phoneNumber
            .bind(to: viewModel.phoneNumber)
            .disposed(by: disposeBag)
        
        continueButton.rx.tap
            .bind(to: viewModel.signUp)
            .disposed(by: disposeBag)
        
        viewModel.observeValidateContent()
            .drive(onNext: { [weak self] validationProblems in
                self?.continueButton.isEnabled = validationProblems.isEmpty
            })
            .disposed(by: disposeBag)
    }
    
    private func addActions() {
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    
    private func whenKeyboard() {
    view.rx.keyboardHeight
        .subscribe(onNext: { [weak self] keyboardHeight in
            self?.titleLabelTopConstraint.constant = keyboardHeight > 0 ? 90 : 170
            UIView.animate(withDuration: 0.4, animations: {
                self?.view.layoutIfNeeded()
            })
        })
        .disposed(by: disposeBag)
    }
}
