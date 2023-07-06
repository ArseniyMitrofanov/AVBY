//
//  SuperSearchViewController.swift
//  AVBY
//
//  Created by Арсений on 28.04.23.
//

import Foundation
import UIKit
class SuperSearchViewController: UIViewController {
    private lazy var engineType: String = EngineType.disel
    private lazy var gearBox: String = GearBoxType.automatic
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var engineTypeButton: UIButton = { [weak self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("дизель", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(showEngineTypeMenu), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    private lazy var gearBoxButton: UIButton = { [weak self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("автомат", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(showGearBoxMenu), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    private lazy var brandTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Марка"
        textField.delegate = self
        return textField
    }()
    private lazy var lYearTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.placeholder = "Год<"
        textField.delegate = self
        return textField
    }()
    private lazy var uYearTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.placeholder = "<Год"
        textField.delegate = self
        return textField
    }()
    private lazy var lPriceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.placeholder = "<Цена($)"
        textField.delegate = self
        return textField
    }()
    private lazy var uPriceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.placeholder = "<Цена($)"
        textField.delegate = self
        return textField
    }()
    private lazy var lMileageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.placeholder = "Пробег(км)<"
        textField.delegate = self
        return textField
    }()
    private lazy var uMileageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.placeholder = "<Пробег(км)"
        textField.delegate = self
        return textField
    }()
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Модельный ряд"
        textField.delegate = self
        return textField
    }()
    private lazy var searchButton: UIButton = {[weak self]  in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.layer.cornerRadius = 5
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(searchCar), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraints()
    }
    func makeConstraints(){
        
        self.view.addSubview(verticalStackView)
        
        verticalStackView.addArrangedSubview(engineTypeButton)
        verticalStackView.addArrangedSubview(gearBoxButton)
        verticalStackView.addArrangedSubview(brandTextField)
        verticalStackView.addArrangedSubview(nameTextField)
        let yHorStView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 5
            view.distribution = .fillEqually
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addArrangedSubview(lYearTextField)
            view.addArrangedSubview(uYearTextField)
            return view
        }()
        verticalStackView.addArrangedSubview(yHorStView)
        let mHorStView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 5
            view.distribution = .fillEqually
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addArrangedSubview(lMileageTextField)
            view.addArrangedSubview(uMileageTextField)
            return view
        }()
        verticalStackView.addArrangedSubview(mHorStView)
        let pHorStView: UIStackView = {
            let view = UIStackView()
            view.axis = .horizontal
            view.spacing = 5
            view.distribution = .fillEqually
            view.translatesAutoresizingMaskIntoConstraints = false
            view.addArrangedSubview(lPriceTextField)
            view.addArrangedSubview(uPriceTextField)
            return view
        }()
        verticalStackView.addArrangedSubview(pHorStView)
        verticalStackView.addArrangedSubview(searchButton)
        
        
        
        NSLayoutConstraint.activate([
            
            verticalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            verticalStackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            brandTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            nameTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            yHorStView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            mHorStView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            gearBoxButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            engineTypeButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            pHorStView.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            searchButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            
            
        ])
    }
    @objc func searchCar(){
        if (lYearTextField.text != nil) &&
            (Int(lYearTextField.text!) != nil) &&
            (uYearTextField.text != nil) &&
            (Int(uYearTextField.text!) != nil) &&
            (Int(lYearTextField.text!)! <= Int(uYearTextField.text!)!) &&
            (lPriceTextField.text != nil) &&
            (Int(lPriceTextField.text!) != nil) &&
            (uPriceTextField.text != nil) &&
            (Int(uPriceTextField.text!) != nil) &&
            (Int(lPriceTextField.text!)! <= Int(uPriceTextField.text!)!) &&
            (lMileageTextField.text != nil) &&
            (Int(lMileageTextField.text!) != nil) &&
            (uMileageTextField.text != nil) &&
            (Int(uMileageTextField.text!) != nil) &&
            (Int(lMileageTextField.text!)! <= Int(uMileageTextField.text!)!) &&
            brandTextField.text != nil &&
            nameTextField.text != nil  {
            var arrayCars = CarsService.shared.fetchArrayCars()
                arrayCars = arrayCars.filter { car in
                    car.brand.contains(brandTextField.text!) &&
                    car.name.contains(nameTextField.text!) &&
                    (Int(lYearTextField.text!)! <= car.year) &&
                     (car.year <= Int(uYearTextField.text!)!) &&
                    (Int(lPriceTextField.text!)! <= car.price) &&
                     (car.price <= Int(uPriceTextField.text!)!) &&
                    (Int(lMileageTextField.text!)! <= car.mileage) &&
                     (car.mileage <= Int(uMileageTextField.text!)!) &&
                    (car.gearBoxType == gearBox) &&
                    (car.engineType == engineType)
                
            }
            Singleton.shared.vcShouldSuperSearch = true
            Singleton.shared.arrayCars = arrayCars
            navigationController?.popViewController(animated: true)
        }
        
    }
    @objc func showEngineTypeMenu(_ sender: UIButton) {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menu.addAction(UIAlertAction(title: "дизель", style: .default, handler: { [weak self] _ in
            self!.engineType = EngineType.disel
            sender.setTitle("дизель", for: .normal)
        }))
        menu.addAction(UIAlertAction(title: "бензин", style: .default, handler: { [weak self] _ in
            self!.engineType = EngineType.petrol
            sender.setTitle("бензин", for: .normal)
        }))
        menu.addAction(UIAlertAction(title: "газ", style: .default, handler: {[weak self] _ in
            self!.engineType = EngineType.gas
            sender.setTitle("газ", for: .normal)
        }))
        menu.addAction(UIAlertAction(title: "электро", style: .default, handler: {[weak self] _ in
            self!.engineType = EngineType.electic
            sender.setTitle("электро", for: .normal)
        }))
        menu.addAction(UIAlertAction(title: "гибрид", style: .default, handler: {[weak self] _ in
            self!.engineType = EngineType.hybrid
            sender.setTitle("гибрид", for: .normal)
        }))
        menu.popoverPresentationController?.sourceView = sender
        menu.popoverPresentationController?.sourceRect = sender.bounds
        present(menu, animated: true, completion: nil)
    }
    @objc func showGearBoxMenu(_ sender: UIButton) {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menu.addAction(UIAlertAction(title: "автомат", style: .default, handler: { [weak self] _ in
            self!.gearBox = GearBoxType.automatic
            sender.setTitle("автомат", for: .normal)
        }))
        menu.addAction(UIAlertAction(title: "механика", style: .default, handler: { [weak self] _ in
            self!.gearBox = GearBoxType.manual
            sender.setTitle("механика", for: .normal)
        }))
        menu.addAction(UIAlertAction(title: "вариатор", style: .default, handler: {[weak self] _ in
            self!.gearBox = GearBoxType.variator
            sender.setTitle("вариатор", for: .normal)
        }))
        menu.popoverPresentationController?.sourceView = sender
        menu.popoverPresentationController?.sourceRect = sender.bounds
        present(menu, animated: true, completion: nil)
    }
}
extension SuperSearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("hehehe")
        return true
    }
}
