//
//  RollerShotterViewController.swift
//  ModuloTechTestTechnique
//
//  Created by Nathan on 25/07/2022.
//

import UIKit


class RollerShotterViewController: UIViewController {
    
    
    private lazy var titre: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 38)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Roller"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        setup()
    }
    
}

private extension RollerShotterViewController {
    func setup() {
        setupInterface()
        setupConstraints()
    }
    
    func setupInterface() {
        view.addSubview(titre)
        view.backgroundColor = .white
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titre.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titre.topAnchor.constraint(equalTo: view.topAnchor, constant: 80)
            
        ])
    }
}

