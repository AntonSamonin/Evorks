//
//  TableViewCell.swift
//  Evorks
//
//  Created by Anton Samonin on 2/12/20.
//  Copyright © 2020 AntonSamonin. All rights reserved.
//

import UIKit
import RxSwift

class OrderViewCell: UITableViewCell {
    
    enum CellType {
        case new, confirmed, reserved
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var confirmedContainerView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 1, green: 0.7490196078, blue: 0.7490196078, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var inReserveContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.9568627451, blue: 0.8666666667, alpha: 1)
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
    private let disposeBag = DisposeBag()
    
    var tap: ((Order) -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configure() {
        addSubviews()
    }
    
    private func bind(order: Order) {
        self.order = order
    }
    
    private func addSubviews() {
        addSubview(containerView)
        addSubview(confirmedContainerView)
        addSubview(inReserveContainerView)
        addSubview(titleLabel)
        
    }
    
}
