//
//  CreateCarViewController.swift
//  AVBY
//
//  Created by Арсений on 30.03.23.
//

import Foundation
import UIKit
class CreateCarViewController: UIViewController, UITextFieldDelegate {
    private lazy var bodyType: String = BodyType.sedan
    private var carImage: UIImage?
    private lazy var engineType: String = EngineType.disel
    private lazy var gearBox: String = GearBoxType.automatic
    private lazy var imagePicker: ImagePicker = {
        let imagePicker = ImagePicker()
        imagePicker.delegate = self
        return imagePicker
    }()
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 5
        view.distribution = .fill
        view.alignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var brandTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Марка"
        textField.delegate = self
        return textField
    }()
    private lazy var yearTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
     
        textField.placeholder = "Год"
        textField.delegate = self
        return textField
    }()
    private lazy var priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect

        textField.placeholder = "Цена($)"
        textField.delegate = self
        return textField
    }()
    private lazy var mileageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
     
        textField.placeholder = "Пробег(км)"
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
    private lazy var volumeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        
        textField.placeholder = "Обьем двигателя"
        textField.delegate = self
        return textField
    }()
    private lazy var hpTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect

        textField.placeholder = "Мощность(лс)"
        textField.delegate = self
        return textField
    }()
    private lazy var colorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Цвет"
        textField.delegate = self
        return textField
    }()
    private lazy var carDescription: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Описание"
        textField.delegate = self
        return textField
    }()
    private lazy var contactTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Конакты продавца"
        textField.delegate = self
        return textField
    }()
    private lazy var photoButton: UIButton = {[weak self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(photoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bodyTypeButton: UIButton = { [weak self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("седан", for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(showBodyTypeMenu), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
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
    
    private lazy var createCarButton: UIButton = {[weak self]  in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.layer.cornerRadius = 5
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.addTarget(self, action: #selector(createCar), for: .touchUpInside)
        return button
    }()
    let carImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeConstraints()
    }
    
    func makeConstraints(){
        self.view.addSubview(carImageView)
        self.view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(photoButton)
        verticalStackView.addArrangedSubview(bodyTypeButton)
        verticalStackView.addArrangedSubview(engineTypeButton)
        verticalStackView.addArrangedSubview(gearBoxButton)
        verticalStackView.addArrangedSubview(brandTextField)
        verticalStackView.addArrangedSubview(nameTextField)
        verticalStackView.addArrangedSubview(colorTextField)
        verticalStackView.addArrangedSubview(yearTextField)
        verticalStackView.addArrangedSubview(mileageTextField)
        verticalStackView.addArrangedSubview(volumeTextField)
        verticalStackView.addArrangedSubview(hpTextField)
        verticalStackView.addArrangedSubview(priceTextField)
        verticalStackView.addArrangedSubview(carDescription)
        verticalStackView.addArrangedSubview(contactTextField)
        verticalStackView.addArrangedSubview(createCarButton)
        
        
        NSLayoutConstraint.activate([
            carImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            carImageView.widthAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            carImageView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.widthAnchor),
            verticalStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            verticalStackView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            photoButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            photoButton.heightAnchor.constraint(equalTo: brandTextField.heightAnchor),
            brandTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            nameTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            colorTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            yearTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            mileageTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            volumeTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            hpTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            gearBoxButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            carDescription.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            engineTypeButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            bodyTypeButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            contactTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            priceTextField.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            createCarButton.widthAnchor.constraint(equalTo: verticalStackView.widthAnchor, multiplier: 0.7),
            
            
        ])
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)

        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.view.frame.origin.y -= 170
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
         self.view.frame.origin.y += 170
        return true
    }
    
    @objc func showBodyTypeMenu(_ sender: UIButton) {
        let menu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        menu.addAction(UIAlertAction(title: "седан", style: .default, handler: { [weak self] _ in
            self!.bodyType = BodyType.sedan
            sender.setTitle("седан", for: .normal)
        }))
        menu.addAction(UIAlertAction(title: "купе", style: .default, handler: { [weak self] _ in
            self!.bodyType = BodyType.coupe
            sender.setTitle("купе", for: .normal)
        }))
        menu.addAction(UIAlertAction(title: "универсал", style: .default, handler: {[weak self] _ in
            self!.bodyType = BodyType.shotingBrake
            sender.setTitle("универсал", for: .normal)
        }))
        menu.popoverPresentationController?.sourceView = sender
        menu.popoverPresentationController?.sourceRect = sender.bounds
        present(menu, animated: true, completion: nil)
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
    @objc func photoButtonTapped(_ sender: UIButton) { imagePicker.photoGalleryAsscessRequest() }
    @objc func createCar(){
        self.view.endEditing(true)
        if  brandTextField.text != nil &&
                nameTextField.text != nil &&
                colorTextField.text != nil &&
                yearTextField.text != nil &&
                Int(yearTextField.text!) != nil &&
                carDescription.text != nil &&
                mileageTextField.text != nil &&
                Int(mileageTextField.text!) != nil &&
                volumeTextField.text != nil &&
                Double(volumeTextField.text!) != nil &&
                hpTextField.text != nil &&
                Int(hpTextField.text!) != nil &&
                priceTextField.text != nil &&
                Int(priceTextField.text!) != nil &&
                contactTextField.text != nil {
            let newCar = Car(brand: brandTextField.text!, year: Int(yearTextField.text!)!, price: Int(priceTextField.text!)!, mileage: Int(mileageTextField.text!)!, name: nameTextField.text!, volume: Double(volumeTextField.text!)!, horsePower: Int(hpTextField.text!)!, gearBoxType: gearBox, color: colorTextField.text!, bodyType: bodyType, description: carDescription.text!, engineType: engineType, ownerContacts: contactTextField.text!, photo: carImageView.image ?? UIImage(systemName: "car")!)
            CarsService.shared.addCar(car: newCar)
            CarsService.shared.postCar(car: newCar)
            navigationController?.popViewController(animated: true)
        }
    }
}

extension CreateCarViewController: ImagePickerDelegate {
    
    func imagePicker(_ imagePicker: ImagePicker, didSelect image: UIImage) {
        self.carImageView.image = image
        imagePicker.dismiss()
    }
    
    func cancelButtonDidClick(on imageView: ImagePicker) { imagePicker.dismiss() }
    func imagePicker(_ imagePicker: ImagePicker, grantedAccess: Bool,
                     to sourceType: UIImagePickerController.SourceType) {
        guard grantedAccess else { return }
        imagePicker.present(parent: self, sourceType: sourceType)
    }
}



