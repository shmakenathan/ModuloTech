//
//  DeviceListTableViewCell.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//

import UIKit



final class DeviceListTableViewCell: UITableViewCell {
    
    static let identifier = "DeviceListTableViewCell"
    
    
    func configure(viewModel: DeviceViewModel) {
        titleLabel.text = viewModel.deviceName
        stateLabel.text = viewModel.stateDescription
        
        if let iconImageName = viewModel.iconImageName {
            iconImageView.image = UIImage(named: iconImageName)
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                iconImageView,
                titleAndStateStackView,
                goToDetailsIndicatorView
            ]
        )
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: The following constraint create console warning - It should be solved
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 100)
        ])
        return stackView
    }()
    
    private let goToDetailsIndicatorView: UIView = {
        let image = UIImage(systemName: "chevron.right")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false

        
        let containerView = UIView()
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        let distanceFromBorder: CGFloat = 38.0
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: distanceFromBorder),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -distanceFromBorder),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        
        
        
        return containerView
    }()
    
    private lazy var titleAndStateStackView: UIStackView = {
 
        let stackView = UIStackView(
            arrangedSubviews: [
                titleLabel,
                stateLabel
            ]
        )
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 60)
        ])
        return imageView
    }()
    
}
