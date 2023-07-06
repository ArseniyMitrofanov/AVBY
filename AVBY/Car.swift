//
//  Car.swift
//  AVBY
//
//  Created by Арсений on 29.03.23.
//

import Foundation
import UIKit

enum BodyType {
    static let sedan = "sedan"
    static let coupe = "coupe"
    static let shotingBrake = "shotingBrake"
}

enum GearBoxType {
    static let automatic = "automatic"
    static let manual = "manual"
    static let variator = "variator"
}
enum EngineType {
    static let disel = "disel"
    static let petrol = "petrol"
    static let gas = "gas"
    static let electic = "electic"
    static let hybrid = "hybrid"
}

struct Car: Hashable {
  
    let brand: String//
    let year: Int//
    let price: Int//
    let mileage: Int//
    let name: String//
    let volume: Double//
    let horsePower: Int//
    let gearBoxType: String//////////////////////////
    let color: String//
    let bodyType: String//
    let description: String//////////////////////////////////
    let engineType: String//
    let ownerContacts: String//////////////////////////////////////
    let photo: UIImage//
    
    init(brand: String, year: Int, price: Int, mileage: Int, name: String, volume: Double, horsePower: Int, gearBoxType: String, color: String, bodyType: String, description: String, engineType: String, ownerContacts: String, photo: UIImage) {
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

struct CarWithURL{
    let brand: String//
    let year: Int//
    let price: Int//
    let mileage: Int//
    let name: String//
    let volume: Double//
    let horsePower: Int//
    let gearBoxType: String//////////////////////////
    let color: String//
    let bodyType: String//
    let description: String//////////////////////////////////
    let engineType: String//
    let ownerContacts: String//////////////////////////////////////
    let photo: String//
}
