//
//  OrderDetailsViewController.swift
//  Evorks
//
//  Created by Anton Samonin on 2/17/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OrderDetailsViewController: UIViewController {
    
    var order: Order?
    private let disposeBag = DisposeBag()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "composition_of_work".localized, at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "prompt".localized, at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private lazy var compositionOfWorkContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "descriptionLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startOfWorkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "startOfWorkLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var endOFWorkLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "endOFWorkLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "addressLabel"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var costContainerView: UIView = {
        let view = UIView()
        view.borderWidth = 1
        view.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var priceFormationLabel: UILabel = {
        let label = UILabel()
        let attr = TextAttributes()
            .font(Font.Montserrat.regular(size: 14))
            .textColor(UIColor.black)
        label.numberOfLines = 0
        label.attributedText = "price_formed".localized.attributed(with: attr)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var priceLable: UILabel = {
        let label = UILabel()
        label.font = Font.Montserrat.bold(size: 38)
        label.textColor = .black
        label.text = "1200"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var buttonsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var approveButton: UIButton = {
        let button = UIButton()
        let attr = TextAttributes()
        .font(Font.Montserrat.bold(size: 16))
            .textColor(.white)
        button.backgroundColor = #colorLiteral(red: 1, green: 0.4, blue: 0.4, alpha: 1)
        button.setAttributedTitle("approve".localized.attributed(with: attr), for: .normal)
        button.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var toReserveButton: UIButton = {
        let button = UIButton()
        let attr = TextAttributes()
        .font(Font.Montserrat.bold(size: 16))
            .textColor(.white)
        button.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.7568627451, blue: 0.3568627451, alpha: 1)
        button.setAttributedTitle("to_reserve".localized.attributed(with: attr), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var promptContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var promptTextView: UITextView = {
        let textView = UITextView()
        let attr = TextAttributes()
            .font(Font.Montserrat.regular(size: 14))
            .textColor(.black)
        textView.attributedText = "order_prompt".localized.attributed(with: attr)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    init(order: Order?) {
        super.init(nibName: nil, bundle: nil)
        self.order = order
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupNavigationBar()
    }
    
    private func configure() {
        addSubviews()
        bind()
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(segmentedControl)
        scrollView.addSubview(compositionOfWorkContainerView)
        scrollView.addSubview(costContainerView)
        scrollView.addSubview(promptContainer)
        view.addSubview(buttonsContainerView)
        compositionOfWorkContainerView.addSubview(descriptionLabel)
        compositionOfWorkContainerView.addSubview(startOfWorkLabel)
        compositionOfWorkContainerView.addSubview(endOFWorkLabel)
        compositionOfWorkContainerView.addSubview(addressLabel)
        promptContainer.addSubview(promptTextView)
        costContainerView.addSubview(priceFormationLabel)
        costContainerView.addSubview(priceLable)
        buttonsContainerView.addSubview(approveButton)
        buttonsContainerView.addSubview(toReserveButton)
        
        
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        segmentedControl.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 14).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 17).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -17).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 38).isActive = true
        
        
        compositionOfWorkContainerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        compositionOfWorkContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        compositionOfWorkContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        costContainerView.topAnchor.constraint(equalTo: compositionOfWorkContainerView.bottomAnchor).isActive = true
        costContainerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        costContainerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        costContainerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        costContainerView.heightAnchor.constraint(equalToConstant: 94).isActive = true
        costContainerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        buttonsContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonsContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        buttonsContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttonsContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 82/568).isActive = true
        
        promptContainer.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor).isActive = true
        promptContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        promptContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        promptContainer.bottomAnchor.constraint(equalTo: costContainerView.topAnchor).isActive = true
        
        let compositionOfWorkConstraints: [NSLayoutConstraint] = [
            descriptionLabel.topAnchor.constraint(equalTo: compositionOfWorkContainerView.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: compositionOfWorkContainerView.leadingAnchor, constant: 17),
            descriptionLabel.trailingAnchor.constraint(equalTo: compositionOfWorkContainerView.trailingAnchor, constant: -17),
            
            startOfWorkLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 15),
            startOfWorkLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            startOfWorkLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            endOFWorkLabel.topAnchor.constraint(equalTo: startOfWorkLabel.bottomAnchor, constant: 15),
            endOFWorkLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            endOFWorkLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            
            addressLabel.topAnchor.constraint(equalTo: endOFWorkLabel.bottomAnchor, constant: 15),
            addressLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor),
            addressLabel.bottomAnchor.constraint(equalTo: compositionOfWorkContainerView.bottomAnchor, constant: -23)
        ]
        
        let costContainerConstraints: [NSLayoutConstraint] = [
            priceFormationLabel.centerYAnchor.constraint(equalTo: costContainerView.centerYAnchor),
            priceFormationLabel.leadingAnchor.constraint(equalTo: costContainerView.leadingAnchor, constant: 28),
            
            priceLable.centerYAnchor.constraint(equalTo: costContainerView.centerYAnchor),
            priceLable.trailingAnchor.constraint(equalTo: costContainerView.trailingAnchor, constant: -28),
            
            
            priceFormationLabel.trailingAnchor.constraint(equalTo: priceLable.leadingAnchor, constant: -50)
        ]
        
        let promptContainerConstraints: [NSLayoutConstraint] = [
            promptTextView.topAnchor.constraint(equalTo: promptContainer.topAnchor, constant: 20),
            promptTextView.leadingAnchor.constraint(equalTo: promptContainer.leadingAnchor, constant: 27),
            promptTextView.trailingAnchor.constraint(equalTo: promptContainer.trailingAnchor, constant: -27),
            promptTextView.bottomAnchor.constraint(equalTo: promptContainer.bottomAnchor)
        ]
        
        let buttonsContainerCinstraints: [NSLayoutConstraint] = [
            approveButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor),
            approveButton.leadingAnchor.constraint(equalTo: buttonsContainerView.leadingAnchor, constant: 27),
            approveButton.trailingAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor, constant: -2),
            approveButton.heightAnchor.constraint(equalToConstant: 53),
            
            toReserveButton.centerYAnchor.constraint(equalTo: buttonsContainerView.centerYAnchor),
            toReserveButton.leadingAnchor.constraint(equalTo: buttonsContainerView.centerXAnchor, constant: 2),
            toReserveButton.trailingAnchor.constraint(equalTo: buttonsContainerView.trailingAnchor, constant: -27),
            toReserveButton.heightAnchor.constraint(equalToConstant: 53),
        ]
        
        NSLayoutConstraint.activate(compositionOfWorkConstraints)
        NSLayoutConstraint.activate(costContainerConstraints)
        NSLayoutConstraint.activate(promptContainerConstraints)
        NSLayoutConstraint.activate(buttonsContainerCinstraints)
    }
    
    private func bind() {
        segmentedControl.rx.controlEvent(.valueChanged)
            .bind { [weak self] _ in
                guard let self = self else {return}
                switch self.segmentedControl.selectedSegmentIndex {
                case 0:
                    self.compositionOfWorkContainerView.isHidden = false
                    self.promptContainer.isHidden = true
                case 1:
                    self.compositionOfWorkContainerView.isHidden = true
                    self.promptContainer.isHidden = false
                default:
                    self.compositionOfWorkContainerView.isHidden = false
                    self.promptContainer.isHidden = true
                }
        }
        .disposed(by: disposeBag)
    }
    
    private func setupNavigationBar() {
        if let order = order {
            navigationItem.title = order.orderTitle
        }
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: Font.Montserrat.regular(size: 20)]
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.9176470588, green: 0.9450980392, blue: 0.968627451, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
    }
    
}
