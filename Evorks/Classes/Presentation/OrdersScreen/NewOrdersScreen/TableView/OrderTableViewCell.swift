//
//  TableViewCell.swift
//  Evorks
//
//  Created by Anton Samonin on 2/12/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift

class OrderTableViewCell: UITableViewCell {
    
    enum CellType {
        case new, confirmed, reserved
    }
    
    private let confirmedColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
    private let reservedColor = #colorLiteral(red: 0.8196078431, green: 0.9568627451, blue: 0.8666666667, alpha: 1)
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2196078431, green: 0.2392156863, blue: 0.2745098039, alpha: 1)
        label.font = Font.Montserrat.bold(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var startLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2196078431, green: 0.2392156863, blue: 0.2745098039, alpha: 1)
        label.font = Font.Montserrat.regular(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2196078431, green: 0.2392156863, blue: 0.2745098039, alpha: 1)
        label.font = Font.Montserrat.regular(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var costPerHourLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.6431372549, green: 0.6509803922, blue: 0.6588235294, alpha: 1)
        label.font = Font.Montserrat.regular(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var costPerShiftLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2196078431, green: 0.2392156863, blue: 0.2745098039, alpha: 1)
        label.font = Font.Montserrat.bold(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var personIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "person")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var numberOfPersonsLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2196078431, green: 0.2392156863, blue: 0.2745098039, alpha: 1)
        label.font = Font.Montserrat.regular(size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var vectorIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vector")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2196078431, green: 0.2392156863, blue: 0.2745098039, alpha: 1)
        label.font = Font.Montserrat.regular(size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var inWorkButton: UIButton = {
        let button = UIButton()
        let attr = TextAttributes()
            .font(Font.Montserrat.bold(size: 14))
            .textColor(UIColor.white)
        button.backgroundColor = #colorLiteral(red: 0.1529411765, green: 0.7568627451, blue: 0.3568627451, alpha: 1)
        button.setAttributedTitle("in_work".localized.attributed(with: attr), for: .normal)
        button.cornerRadius = 4
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var order: Order!
    private var disposeBag = DisposeBag()
    
    var tap: ((Order) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
        setUpConstraints(constraints: newOrderConstraints, activate: false)
        setUpConstraints(constraints: confirmedOrderConstraints, activate: false)
        setUpConstraints(constraints: reservedOrderConstraints, activate: false)
    }
    
    private func configure() {
        addSubviews()
    }
    
    private func bind(order: Order, cellType: CellType) {
        self.order = order
        
        switch cellType {
        case .new:
            self.containerView.backgroundColor = .white
            self.startLabel.text = order.startWork
            self.addressLabel.text = order.address
            self.costPerHourLabel.text = String(order.countHours)
            self.numberOfPersonsLabel.text = String(order.countPerson)
            self.setUpConstraints(constraints: newOrderConstraints, activate: true)
        case .confirmed:
            self.containerView.backgroundColor = confirmedColor
            self.startLabel.text = order.startWork
            self.descriptionLabel.text = "order_confirmed".localized
            self.setUpConstraints(constraints: confirmedOrderConstraints, activate: true)
        case .reserved:
            self.containerView.backgroundColor = reservedColor
            self.startLabel.text = order.startWork
            self.descriptionLabel.text = "order_reserved".localized
            self.setUpConstraints(constraints: reservedOrderConstraints, activate: true)
        }
        
        inWorkButton.isHidden = cellType == .confirmed ? false : true
        costPerHourLabel.isHidden = cellType == .new ? false : true
        costPerShiftLabel.isHidden = cellType == .new ? false : true
        numberOfPersonsLabel.isHidden = cellType == .new ? false : true
        personIconImageView.isHidden = cellType == .new ? false : true
    }
    
    private func addSubviews() {
        addSubview(containerView)
        addSubview(titleLabel)
        addSubview(startLabel)
        containerView.addSubview(addressLabel)
        containerView.addSubview(costPerHourLabel)
        containerView.addSubview(costPerShiftLabel)
        containerView.addSubview(personIconImageView)
        containerView.addSubview(numberOfPersonsLabel)
        containerView.addSubview(vectorIconImageView)
        addSubview(descriptionLabel)
        addSubview(inWorkButton)
        
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12).isActive = true
        self.titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 23).isActive = true
        
    }
    
    private lazy var newOrderConstraints: [NSLayoutConstraint] = [
        self.startLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 23),
        self.startLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 10),
        
        self.addressLabel.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 23),
        self.addressLabel.topAnchor.constraint(equalTo: self.startLabel.bottomAnchor, constant: 10),
        self.addressLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 12),
        
        self.vectorIconImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
        self.vectorIconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
        
        self.costPerHourLabel.trailingAnchor.constraint(equalTo: self.vectorIconImageView.leadingAnchor, constant: 22),
        self.costPerHourLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 12),
        
        self.costPerShiftLabel.topAnchor.constraint(equalTo: self.costPerHourLabel.bottomAnchor, constant: 10),
        self.costPerShiftLabel.trailingAnchor.constraint(equalTo: self.vectorIconImageView.leadingAnchor, constant: 22),
        
        self.numberOfPersonsLabel.trailingAnchor.constraint(equalTo: self.vectorIconImageView.leadingAnchor, constant: 22),
        self.numberOfPersonsLabel.topAnchor.constraint(equalTo: self.costPerShiftLabel.bottomAnchor, constant: 10),
        self.numberOfPersonsLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -12)
    ]
    
    private lazy var confirmedOrderConstraints: [NSLayoutConstraint] = [
        self.startLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 15),
        self.startLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -50),
        
        self.inWorkButton.topAnchor.constraint(equalTo: self.startLabel.bottomAnchor, constant: 20),
        self.inWorkButton.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -17),
        self.inWorkButton.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -17),
        self.inWorkButton.heightAnchor.constraint(equalToConstant: 42),
        self.inWorkButton.widthAnchor.constraint(equalToConstant: 153),
        
        self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 20),
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.inWorkButton.leadingAnchor, constant: 11),
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 20)
    ]
    
    private lazy var reservedOrderConstraints: [NSLayoutConstraint] = [
        self.startLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 15),
        self.startLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -50),
        
        self.descriptionLabel.topAnchor.constraint(equalTo: self.startLabel.bottomAnchor, constant: 20),
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor, constant: -100),
        self.descriptionLabel.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 20)
    ]
    
    private func setUpConstraints(constraints: [NSLayoutConstraint], activate: Bool) {
        activate ? NSLayoutConstraint.activate(constraints) : NSLayoutConstraint.deactivate(constraints)
    }
}
