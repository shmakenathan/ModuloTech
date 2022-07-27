//
//  DeviceListViewController.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 25/07/2022.
//

import UIKit

final class DeviceListViewModel {
    private let networkService = NetworkService.shared
    
    var devices: [Device] = [] {
        didSet {
            DispatchQueue.main.async {
                //self.deviceListTableView.reloadData()
            }
        }
    }
    
    func fetchDevicesData() {
        Task {
            let url = URL(string: "http://storage42.com/modulotest/data.json")!
            let urlRequest = URLRequest(url: url)
            if let response: DevicesResponse = try? await networkService.fetch(urlRequest: urlRequest) {
                print("SUCCESS ✅✅")
                print(response)
                self.devices = response.devices
                
                
            } else {
                print("FAILED ❌❌❌")
            }
        }
    }
}

final class DeviceListViewController: UIViewController {
    // MARK: - INTERNAL
    
    // MARK: Internal - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        viewModel.fetchDevicesData()
    }
    
    // MARK: - PRIVATE
    
    // MARK: Private - Properties
    
    private let viewModel = DeviceListViewModel()
  
    private lazy var deviceListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(DeviceListTableViewCell.self, forCellReuseIdentifier: DeviceListTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
  
}


extension DeviceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationViewController = DeviceDetailsViewController()
        destinationViewController.device = viewModel.devices[indexPath.row]
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
}

extension DeviceListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let device = viewModel.devices[indexPath.row]
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: DeviceListTableViewCell.identifier) as? DeviceListTableViewCell) ??
                DeviceListTableViewCell(style: .default, reuseIdentifier: DeviceListTableViewCell.identifier)
        
        cell.configure(model: device)
        return cell
        
    }
    
    
}





private extension DeviceListViewController {
    func setup() {
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        view.backgroundColor = .white
        title = "My Devices"
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
