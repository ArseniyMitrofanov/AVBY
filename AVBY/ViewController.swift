//
//  ViewController.swift
//  AVBY
//
//  Created by Арсений on 16.03.23.
//

import UIKit

class ViewController: UIViewController {
    let horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 5
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let textField: UITextField = {
        let view = UITextField()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.borderStyle = .roundedRect
        view.placeholder = "Введите название авто"
        return view
    }()
    let searchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()
    let superSearchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      makeLayout()
    }
    
    func makeLayout(){
        self.view.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(superSearchButton)
        horizontalStackView.addArrangedSubview(textField)
        horizontalStackView.addArrangedSubview(searchButton)
        
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor,constant: 5),
            horizontalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            superSearchButton.widthAnchor.constraint(equalToConstant: 70),
            searchButton.widthAnchor.constraint(equalToConstant: 70),
                                     
                                     
        ])
        
    }
    
}

