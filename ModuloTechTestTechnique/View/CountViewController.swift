//
//  TestViewController.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 01/08/2022.
//

import Foundation
import UIKit

import RxSwift
import RxCocoa


final class CountViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
        
        
        
        
    }
    
    
    
    
    private lazy var mainStackView: UIStackView = {
        
        let stackView = UIStackView(arrangedSubviews: [
            countLabel,
            plusButton,
            minusButton
        ])
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    
    private lazy var countLabel: UILabel = {
        
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        
        
        viewModel.countValueRelay
            .subscribe(on: MainScheduler.instance)
            .map { $0.description }
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    private lazy var plusButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.rx
            .tap
            .bind { [weak self] in self?.viewModel.IncrementCount() }
            .disposed(by: disposeBag)
        //button.addTarget(self, action: #selector(didTapPlusButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        
        button.rx
            .tap
            .bind { [weak self] in self?.viewModel.decrementCount() }
            .disposed(by: disposeBag)
        //button.addTarget(self, action: #selector(didTapMinusButton), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    

    //{
    //    didSet {
    //        countLabel.text = countValue.description
    //    }
    //}
    //
    
    
   
    
    
    private let disposeBag = DisposeBag()
    private let viewModel = CountViewModel()
    
}




final class CountViewModel {
    let countValueRelay = BehaviorRelay<Int>(value: 0)
    
    func IncrementCount() {
        countValueRelay.accept(countValueRelay.value + 1)
    }
    
    func decrementCount() {
        countValueRelay.accept(countValueRelay.value - 1)
    }
}
