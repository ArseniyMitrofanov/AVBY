//
//  CarViewController.swift
//  AVBY
//
//  Created by Арсений on 28.04.23.
//

import Foundation
import UIKit

class CarViewController: UIViewController {
    
    var car: Car!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let ImageView = UIImageView(image: car.photo)
        ImageView.contentMode = .scaleAspectFill
        ImageView.clipsToBounds = true
        ImageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width)
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.frame = CGRect(x: 10, y: self.view.frame.width, width: self.view.frame.width - 20, height: self.view.frame.height - self.view.frame.width - 80)
        stackView.distribution = .fillProportionally
        stackView.backgroundColor = .white
        let brandLabel = UILabel()
        brandLabel.text = car.brand
        brandLabel.font = .boldSystemFont(ofSize: 25)
        let nameLabel = UILabel()
        nameLabel.text = car.name
        nameLabel.font = .boldSystemFont(ofSize: 20)
        let bodyLabel = UILabel()
        bodyLabel.font = .systemFont(ofSize: 20)
        bodyLabel.text = car.color + " "
        switch car.bodyType {
            
        case BodyType.sedan:
            bodyLabel.text?.append("седан")
        case BodyType.coupe:
            bodyLabel.text?.append("купе")
        case BodyType.shotingBrake:
            bodyLabel.text?.append("универсал")
        default:
            print("error")
        }
        let gearLabel = UILabel()
        gearLabel.font = .systemFont(ofSize: 20)
        switch car.gearBoxType{
            
        case GearBoxType.automatic:
            gearLabel.text = "Автомат"
        case GearBoxType.manual:
            gearLabel.text = "Механика"
        case GearBoxType.variator:
            gearLabel.text = "Вариатор"
        default:
            print("error")
        }
        let yearMileageLabel = UILabel()
        yearMileageLabel.font = .systemFont(ofSize: 20)
        yearMileageLabel.text = String(car.year) + ", " + String(car.mileage) + " км "
        let engineLabel = UILabel()
        engineLabel.font = .systemFont(ofSize: 20)
        engineLabel.text = ""
        switch car.engineType {
        case EngineType.disel:
            engineLabel.text?.append(String(car.volume) + " л. Дизель, ")
        case EngineType.petrol:
            engineLabel.text?.append(String(car.volume) + " л. Бензин, ")
        case EngineType.gas:
            engineLabel.text?.append(String(car.volume) + " л. Газ, ")
        case EngineType.electic:
            engineLabel.text?.append("электро, ")
        case EngineType.hybrid:
            engineLabel.text?.append(String(car.volume) + " л. Гибрид, ")
        default:
            print("error")
        }
        engineLabel.text?.append(String(car.horsePower) + " л. с.")
        let descriptionLabel = UILabel()
        descriptionLabel.numberOfLines = 6
        descriptionLabel.text = car.description
        let priceLabel = UILabel()
        priceLabel.text = String(car.price) + " $"
        priceLabel.font = .systemFont(ofSize: 20)
        priceLabel.textColor = .red
        let contactLabel = UILabel()
        contactLabel.text = car.ownerContacts
        contactLabel.font = .systemFont(ofSize: 20)
        stackView.addArrangedSubview(brandLabel)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(bodyLabel)
        stackView.addArrangedSubview(gearLabel)
        stackView.addArrangedSubview(yearMileageLabel)
        stackView.addArrangedSubview(engineLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(contactLabel)
        self.view.addSubview(stackView)
        self.view.addSubview(ImageView)
       
    }
    
}

