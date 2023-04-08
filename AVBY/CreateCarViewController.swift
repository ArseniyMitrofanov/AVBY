//
//  CreateCarViewController.swift
//  AVBY
//
//  Created by Арсений on 30.03.23.
//

import Foundation
import UIKit
//let brand: String
//let year: Int
//let price: Int
//let mileage: Int
//let name: String
//let volume: Double
//let horsePower: Int
//let color: String
//let bodyType: BodyType
//let description: String
//let engineType: EngineType
//let ownerContacts: String
//let photo: UIImage
class CreateCarViewController: UIViewController {
    let brandTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Марка"
        return textField
    }()
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Год"
        return textField
    }()
    let priceTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Цена($)"
        return textField
    }()
    let mileageTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Пробег(км)"
        return textField
    }()
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Модельный ряд"
        return textField
    }()
    let volumeTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Обьем двигателя"
        return textField
    }()
    let hpTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Мощность(лс)"
        return textField
    }()
    let colorTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Цвет"
        return textField
    }()
    let contactTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Конакты продавца"
        return textField
    }()
    let photoButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageView?.image = UIImage(systemName: "camera")
            return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}
