//
//  DeviceListViewController.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 25/07/2022.
//

import UIKit

final class DeviceListViewController: UIViewController {
    
    private lazy var deviceListTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    //lazy var nextButton: UIButton = {
    //    let button = UIButton()
    //    button.translatesAutoresizingMaskIntoConstraints = false
    //    button.setTitle("Citation suivante".uppercased(), for: .normal)
    //    button.backgroundColor = UIColor(red: 0.827, green: 0.102, blue: 0.431, alpha: 1)
    //    button.addTarget(self, action: #selector(suivant), for: .touchUpInside)
    //    //button.addAction(.init(handler: {_ in nextCitation() }), for: .touchUpInside)
    //    return button
    //}()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
        
        setup()
        
    }
    @objc func suivant() {
        let controller = RollerShotterViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
        return
    }
    
    
    private let networkService = NetworkService.shared
    
    
    private var devices: [Device] = [] {
        didSet {
            DispatchQueue.main.async {
                self.deviceListTableView.reloadData()
            }
           
        }
    }
}


extension DeviceListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destinationViewController = DeviceDetailsViewController()
        destinationViewController.device = devices[indexPath.row]
        navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
}

extension DeviceListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        devices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let device = devices[indexPath.row]
        let deviceCellIdentifier = "DeviceCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: deviceCellIdentifier) ??
                    UITableViewCell(style: .default, reuseIdentifier: deviceCellIdentifier)
        
        
        cell.textLabel?.text = device.deviceName
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
