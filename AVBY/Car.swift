//
//  Car.swift
//  AVBY
//
//  Created by Арсений on 29.03.23.
//

import Foundation
import UIKit

enum BodyType {
    case sedan
    case coupe
    case shotingBrake
}

enum GearBoxType {
    case automatic
    case manual
    case variator
}
enum EngineType {
    case disel
    case petrol
    case gas
    case electic
    case hybrid
}

struct Car: Hashable {
  
    let brand: String
    let year: Int
    let price: Int
    let mileage: Int
    let name: String
    let volume: Double
    let horsePower: Int
    let gearBoxType: GearBoxType
    let color: String
    let bodyType: BodyType
    let description: String
    let engineType: EngineType
    let ownerContacts: String
    let photo: UIImage
    
    init(brand: String, year: Int, price: Int, mileage: Int, name: String, volume: Double, horsePower: Int, gearBoxType: GearBoxType, color: String, bodyType: BodyType, description: String, engineType: EngineType, ownerContacts: String, photo: UIImage) {
        self.brand = brand
        self.year = year
        self.price = price
        self.mileage = mileage
        self.name = name
        self.volume = volume
        self.horsePower = horsePower
        self.gearBoxType = gearBoxType
        self.color = color
        self.bodyType = bodyType
        self.description = description
        self.engineType = engineType
        self.ownerContacts = ownerContacts
        self.photo = photo
    }
}
