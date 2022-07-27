//
//  DeviceListTableViewCell.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 27/07/2022.
//

import UIKit

class DeviceListTableViewCell: UITableViewCell {
    
    static let identifier = "DeviceListTableViewCell"
    
    
    func configure(model: Device) {
        titleLabel.text = model.deviceName
        stateLabel.text = getStateDescription(from: model)
        
        if let iconImageName = getIconImageName(from: model) {
            iconImageView.image = UIImage(named: iconImageName)
        }
    }
    
    private func getIconImageName(from model: Device) -> String? {
        switch model.productType {
        case .rollerShutter:
            return getRollerShutterImageName(from: model)
        case .light:
            return getLightStateImageName(from: model)
        case .heater:
            return getHeaterStateImageName(from: model)
        }
    }
    
    private func getRollerShutterImageName(from model: Device) -> String? {
        return "DeviceRollerShutterIcon"
    }
    
    private func getLightStateImageName(from model: Device) -> String? {
        switch model.mode {
        case.none: return nil
        case .on: return "DeviceLightOnIcon"
        case .off: return "DeviceLightOffIcon"
        }
    }
    
    private func getHeaterStateImageName(from model: Device) -> String? {
        switch model.mode {
        case.none: return nil
        case .on: return "DeviceHeaterOnIcon"
        case .off: return "DeviceHeaterOffIcon"
        }
    }
    
    private func getStateDescription(from model: Device) -> String {
        switch model.productType {
        case .rollerShutter:
            return getRollerShutterStateDescription(from: model)
        case .light:
            return getLightStateDescription(from: model)
        case .heater:
            return getHeaterStateDescription(from: model)
        }
    }
    
    private func getRollerShutterStateDescription(from model: Device) -> String {
        let undefinedDescription = "Unknown"
        guard let position = model.position else { return undefinedDescription }
        
        switch position {
        case 100:
            return "Opened"
        case 1...99:
            return "Opened at \(position)%"
        case 0:
            return "Closed"
        default:
            return undefinedDescription
        }
    }
    
    private func getLightStateDescription(from model: Device) -> String {
        let undefinedDescription = "Unknown"
        guard let mode = model.mode else { return undefinedDescription }
        
        switch mode {
        case .on: return "On"
        case .off: return "Off"
        }
    }
    
    private func getHeaterStateDescription(from model: Device) -> String {
        let undefinedDescription = "Unknown"
        guard let mode = model.mode else { return undefinedDescription }
        
        switch mode {
        case .on: return "On at \(model.temperature?.description ?? "--")°C"
        case .off: return "Off"
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
                secondStackView,
                UIView()
            ]
        )
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
        ])
        return stackView
    }()
    
    private lazy var secondStackView: UIStackView = {
 
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
        label.text = "--"
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var stateLabel: UILabel = {
        let label = UILabel()
        label.text = "--"
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
