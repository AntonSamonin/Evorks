//
//  SignUpViewController.swift
//  Evorks
//
//  Created by Anton Samonin on 2/8/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SignInViewController: UIViewController {
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLablel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.numberOfLines = 0
        title.font = Font.Montserrat.medium(size: 20)
        title.text = "sign_in_description".localized
        title.textAlignment = .center
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private lazy var loginTextField: UniversalAuthTextField = {
        let login = UniversalAuthTextField()
        let attr = TextAttributes()
            .font(Font.Montserrat.light(size: 16))
            .textColor(UIColor.gray)
        login.headerLabel.text = "login".localized
        login.textField.attributedPlaceholder = "login".localized.attributed(with: attr)
        login.translatesAutoresizingMaskIntoConstraints = false
        return login
    }()
    
    private lazy var passwordTextField: UniversalAuthTextField = {
        let password = UniversalAuthTextField()
        let attr = TextAttributes()
        .font(Font.Montserrat.light(size: 16))
        .textColor(UIColor.gray)
        password.headerLabel.text = "password".localized
        password.textField.isSecureTextEntry = true
        password.textField.attributedPlaceholder = "password".localized.attributed(with: attr)
        password.translatesAutoresizingMaskIntoConstraints = false
        return password
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        let attr = TextAttributes()
            .font(Font.Montserrat.bold(size: 20))
            .textColor(.white)
            .textAlignment(.center)
        button.setAttributedTitle("sign_in".localized.attributed(with: attr), for: .normal)
        button.cornerRadius = 32
        button.borderWidth = 2
        button.borderColor = UIColor.white
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        let attr = TextAttributes()
            .font(Font.Montserrat.regular(size: 16))
            .textColor(.white)
            .textAlignment(.center)
            .underlineColor(UIColor.white)
            .underlineStyle(.single)
        button.setAttributedTitle("sign_up".localized.attributed(with: attr), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        let attr = TextAttributes()
            .font(Font.Montserrat.regular(size: 16))
        .textColor(.white)
        .textAlignment(.center)
        label.attributedText = "or".localized.attributed(with: attr)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signInPreloader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    private var loginTopConstraint: NSLayoutConstraint!
    private let disposeBag = DisposeBag()
    private let viewModel = SignInViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = #colorLiteral(red: 0.07843137255, green: 0.368627451, blue: 0.8901960784, alpha: 1)
        addSubviews()
        bind()
        whenKeyboard()
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(titleLablel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(orLabel)
        view.addSubview(signUpButton)
        view.addSubview(signInPreloader)
        
        logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: SizeUtils.value(largeDevice: 66, smallDevice: 36)).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        titleLablel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 25).isActive = true
        titleLablel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLablel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        titleLablel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        

        loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loginTextField.heightAnchor.constraint(equalToConstant: 86).isActive = true
        loginTopConstraint = loginTextField.topAnchor.constraint(equalTo: titleLablel.bottomAnchor, constant: SizeUtils.value(largeDevice: 60, smallDevice: 60, verySmallDevice: 0))
        loginTopConstraint.isActive = true

        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 86).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 16).isActive = true

        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 42).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 66).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 257).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        orLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 17).isActive = true
        orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        signUpButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 17).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        signInPreloader.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor).isActive = true
        signInPreloader.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor).isActive = true
    }
    
    private func bind() {
        signInButton.rx.tap
            .bind(to: viewModel.signIn)
        .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind(to: viewModel.signUp)
        .disposed(by: disposeBag)
        
        loginTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.login)
            .disposed(by: disposeBag)
        
        passwordTextField.textField.rx.text
            .map { $0 ?? "" }
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.observeValidateContent()
            .drive(onNext: { [weak self] validationProblems in
            self?.signInButton.isEnabled = self?.loginTextField.textField.text?.isEmpty ?? true ? false : validationProblems.isEmpty
            })
            .disposed(by: disposeBag)
        
        signUpButton.rx.tap
            .bind {
            var mainWindow: UIWindow? {
                if #available(iOS 13.0, *) {
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        return windowScene.windows.first
                    }
                }
                return UIApplication.shared.keyWindow
            }
            mainWindow?.rootViewController = SignUpViewController()
        }
        .disposed(by: disposeBag)
    }
    
    private func whenKeyboard() {
        view.rx.keyboardHeight
            .subscribe(onNext: { [weak self] keyboardHeight in
                self?.loginTopConstraint.constant = keyboardHeight > 0 ? SizeUtils.value(largeDevice: 20, smallDevice: 10, verySmallDevice: 0) : SizeUtils.value(largeDevice: 60, smallDevice: 60, verySmallDevice: 0)
                UIView.animate(withDuration: 0.4, animations: {
                    self?.view.layoutIfNeeded()
                })
            })
            .disposed(by: disposeBag)
        
        let tapGesture = UITapGestureRecognizer()
        view.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .subscribe(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }

}
