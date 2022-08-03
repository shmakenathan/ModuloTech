//
//  DeviceDetailsViewController.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 26/07/2022.
//

import UIKit
import RxSwift
import RxCocoa

final class DeviceDetailsViewController: UIViewController {
    
    var viewModel: DeviceViewModel?
    
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
        titleLabel.text = viewModel?.deviceName
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
        if let iconImageName = viewModel?.iconImageName {
            imageView.image = UIImage(named: iconImageName)
        }
        
        if let viewModel = viewModel {
            viewModel.isOnRelay
                .subscribe(on: MainScheduler.instance)
                .map { _ in
                    let iconImageName = viewModel.iconImageName ?? ""
                    let image = UIImage(named: iconImageName)!
                    return image
                }
                .bind(to: imageView.rx.image)
                .disposed(by: disposeBag)
        }
        
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 150)
        ])
        return imageView
    }()
    
    private func getAssociatedView(from deviceControlOptionType: DeviceControlOptionType) -> UIView {
        switch deviceControlOptionType {
        case .slider:
            return sliderControlView
        case .stepper:
            return stepperControlView
        case .toggleSwitch:
            return switchControlView
        }
    }
    
    private lazy var steeringControlsStackView: UIStackView = {
        let stackView = UIStackView()
        if let viewModel = viewModel {
            let controlViews = viewModel.deviceControlOptionTypes.map {
                getAssociatedView(from: $0)
            }
            stackView.addArrangedSubviews(controlViews)
        }

        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    

    
    private lazy var switchControlView: UIView = {
        let view = createControlContainerView()
        let controlLabel = UILabel()
        controlLabel.text = "On/Off"
        controlLabel.textAlignment = .left
        
        let controlSwitch = UISwitch()
        
     
        

        
        if let viewModel = viewModel {
            
            controlSwitch.rx
                .controlEvent(.touchUpInside)
                .withLatestFrom(controlSwitch.rx.value)
                .subscribe(onNext: { _ in viewModel.toggleSwitch() })
                .disposed(by: disposeBag)
            
            viewModel.isOnRelay
                .subscribe(on: MainScheduler.instance)
                .bind(to: controlSwitch.rx.isOn)
                .disposed(by: disposeBag)
        }
        
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
        
        return view
        
    }()
    
    private lazy var sliderControlView: UIView = {
        let view = createControlContainerView()
        
        let controlBeginLabel = UILabel()
        controlBeginLabel.text = "0"
        controlBeginLabel.textAlignment = .left
        let controlEndLabel = UILabel()
        controlEndLabel.text = "100"
        controlEndLabel.textAlignment = .right
        
        let controlSlider = UISlider()
        
        if let viewModel = viewModel {
            controlSlider.rx.value
                .skip(1)
                .map { Int($0 * 100) }
                .bind { viewModel.assignNewSliderValue(value: $0) }
                .disposed(by: disposeBag)
            
            viewModel.sliderValueRelay
                .subscribe(on: MainScheduler.instance)
                .map { (Float($0) / 100.0) }
                .bind(to: controlSlider.rx.value)
                .disposed(by: disposeBag)
        }
        
        
        let stackView = UIStackView(arrangedSubviews: [
            controlBeginLabel,
            controlSlider,
            controlEndLabel
        ])
        
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            view.heightAnchor.constraint(equalToConstant: 70)
        ])
        

        
        return view
    }()
    
    
    private lazy var stepperControlView: UIView = {
        let view = createControlContainerView()
        let temperatureLabel = UILabel()
        temperatureLabel.font = UIFont.systemFont(ofSize: 20)
        

        
        let minusButton = UIButton()
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(.black, for: .normal)
        minusButton.layer.borderWidth = 1
        minusButton.layer.borderColor = UIColor.black.cgColor
        
        let plusButton = UIButton()
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.layer.borderWidth = 1
        plusButton.layer.borderColor = UIColor.black.cgColor
        
        
        let stepperStackView = UIStackView(arrangedSubviews: [minusButton, plusButton])
        stepperStackView.axis = .horizontal
        stepperStackView.distribution = .fillEqually
        
        stepperStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackView = UIStackView(arrangedSubviews: [
            temperatureLabel,
            stepperStackView
            
        ])
        
        
        if let viewModel = viewModel {
            minusButton.rx
                .tap
                .bind { viewModel.decreaseStepperValue() }
                .disposed(by: disposeBag)
            
            plusButton.rx
                .tap
                .bind { viewModel.increaseStepperValue() }
                .disposed(by: disposeBag)

          

            viewModel.stepperValueRelay
                .subscribe(on: MainScheduler.instance)
                .map { "\($0)°C" }
                .bind(to: temperatureLabel.rx.text)
                .disposed(by: disposeBag)
        }
        
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 5
        stackView.distribution = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            view.heightAnchor.constraint(equalToConstant: 70),
            stepperStackView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
      
        
        return view
    }()
    
    private func createControlContainerView() -> UIView {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .black.withAlphaComponent(0.08)
        view.layer.shadowRadius = 10
        view.layer.shadowColor = UIColor.lightGray.cgColor
        return view
    }
    
    
    private let disposeBag = DisposeBag()
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
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
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
