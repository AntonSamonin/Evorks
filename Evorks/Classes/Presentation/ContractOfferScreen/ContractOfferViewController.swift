//
//  ContractOfferViewController.swift
//  Evorks
//
//  Created by Anton Samonin on 2/16/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit

class ContractOfferViewController: UIViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        let attr = TextAttributes()
            .font(Font.Montserrat.bold(size: 17))
            .textColor(#colorLiteral(red: 0.1490196078, green: 0.1490196078, blue: 0.1529411765, alpha: 1))
        label.attributedText = "contract_offer_title".localized.attributed(with: attr)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        let attr = TextAttributes()
        .font(Font.Montserrat.regular(size: 13))
        .textColor(#colorLiteral(red: 0.2549019608, green: 0.2549019608, blue: 0.2549019608, alpha: 1))
        textView.attributedText = "contract_offer".localized.attributed(with: attr)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        let attr = TextAttributes()
        .font(Font.Montserrat.bold(size: 17))
            .textColor(.white)
        button.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.7137254902, blue: 0.2666666667, alpha: 1)
        button.cornerRadius = 4
        button.setAttributedTitle("agree".localized.attributed(with: attr), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        addSubviews()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(textView)
        scrollView.addSubview(button)
        scrollView.addSubview(emptyView)
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 23).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 23).isActive = true
        
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        textView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 376/414).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 376).isActive = true
        
        button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 10).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 354/414).isActive = true
        button.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 200).isActive = true
        button.heightAnchor.constraint(equalToConstant: 61).isActive = true
        
        emptyView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        emptyView.heightAnchor.constraint(equalToConstant: 0).isActive = true
        emptyView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "offer_agreement".localized
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font.Montserrat.regular(size: 20)]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
}
