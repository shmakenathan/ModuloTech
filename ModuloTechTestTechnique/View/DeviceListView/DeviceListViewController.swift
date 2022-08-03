//
//  DeviceListViewController.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 25/07/2022.
//

import UIKit


import RxSwift
import RxCocoa

final class DeviceListViewController: UIViewController, NavigationCoordinating {

    
    // MARK: - INTERNAL
    
    // MARK: Internal - Properties
    
    var navigationCoordinator: NavigationCoordinator?
    
    // MARK: Internal - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchDevicesData()
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let viewModel = DeviceListViewModel()
    
    private let disposeBag = DisposeBag()
  
    private lazy var deviceListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DeviceListTableViewCell.self, forCellReuseIdentifier: DeviceListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        viewModel.deviceViewModelsSubject
            .bind(
                to: tableView.rx.items(
                    cellIdentifier: DeviceListTableViewCell.identifier,
                    cellType: DeviceListTableViewCell.self
                )
            ) { index, deviceViewModel, cell in
                cell.configure(viewModel: deviceViewModel)
            }
            .disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(DeviceViewModel.self)
            .subscribe(onNext: { [weak self] deviceViewModel in
                self?.navigationCoordinator?.eventOccurred(
                    eventType: .deviceInListTapped(viewModelTapped: deviceViewModel)
                )
            })
            .disposed(by: disposeBag)
            
        
        return tableView
    }()
    
  
}



private extension DeviceListViewController {
    func setup() {
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        view.backgroundColor = .white
        title = viewModel.title
        view.addSubview(deviceListTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            deviceListTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            deviceListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            deviceListTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            deviceListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
