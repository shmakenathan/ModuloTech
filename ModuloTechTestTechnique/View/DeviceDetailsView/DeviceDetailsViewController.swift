//
//  DeviceDetailsViewController.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 26/07/2022.
//

import UIKit


final class DeviceDetailsViewController: UIViewController {
    
    var deviceViewModel: DeviceViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        
    }
    
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(
            arrangedSubviews: [
                iconAndTitleStackView,
                steeringControlsStackView,
                UIView()
            ]
        )
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 100
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var iconAndTitleStackView: UIStackView = {
        let titleLabel = UILabel()
        titleLabel.text = deviceViewModel?.deviceName
        titleLabel.textAlignment = .center
        
        let stackView = UIStackView(
            arrangedSubviews: [
                iconImageView,
                titleLabel
            ]
        )
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        if let iconImageName = deviceViewModel?.iconImageName {
            imageView.image = UIImage(named: iconImageName)
        }
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        return imageView
    }()
    
    private lazy var steeringControlsStackView: UIStackView = {
        let stackView = UIStackView()
        
        switch deviceViewModel?.device.productType {
        case .none:
            break
        case .heater:
            stackView.addArrangedSubviews(
                [
                    switchControlView,
                    stepperControlView
                ]
            )
        case .light:
            stackView.addArrangedSubviews(
                [
                    switchControlView,
                    sliderControlView
                ]
            )
        case .rollerShutter:
            stackView.addArrangedSubviews(
                [
                    sliderControlView
                ]
            )
        }
        
        
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        stackView.spacing = 20
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private lazy var switchControlView: UIView = {
        let view = UIView()
        
        let controlLabel = UILabel()
        controlLabel.text = "On/Off"
        controlLabel.textAlignment = .left
        
        let controlSwitch = UISwitch()
        controlSwitch.isOn = deviceViewModel?.device.mode == .on
        
        let stackView = UIStackView(arrangedSubviews: [
            controlLabel,
            controlSwitch
        ])
        
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            view.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        view.layer.cornerRadius = 16
        
        
        view.backgroundColor = .gray // view.layer.shadowColor = .
        
        return view
        
    }()
    
    private lazy var sliderControlView: UIView = {
        let view = UIView()
        
        let controlBeginLabel = UILabel()
        controlBeginLabel.text = "0"
        controlBeginLabel.textAlignment = .left
        let controlEndLabel = UILabel()
        controlEndLabel.text = "100"
        controlEndLabel.textAlignment = .right
        
        let controlSlider = UISlider()
        
        
        let stackView = UIStackView(arrangedSubviews: [
            controlBeginLabel,
            controlSlider,
            controlEndLabel
        ])
        
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            controlEndLabel.widthAnchor.constraint(equalToConstant: 30),
            controlBeginLabel.widthAnchor.constraint(equalToConstant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            view.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        view.layer.cornerRadius = 16
        
        
        controlSlider.backgroundColor = .gray // view.layer.shadowColor = .
        
        return view
    }()
    
    
    private lazy var stepperControlView: UIView = {
        let temperatureLabel = UILabel()
        temperatureLabel.text = "29"
        let stepper = UIStepper()
        let stackView = UIStackView(arrangedSubviews: [
            temperatureLabel,
            stepper
            
        ])
        temperatureLabel.backgroundColor = .black
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 140)
        ])
        return UIView()
    }()
    
    
    
    
}

private extension DeviceDetailsViewController {
    func setup() {
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        view.backgroundColor = .white
        
        view.addSubview(mainStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
