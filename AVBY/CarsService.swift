//
//  CarsService.swift
//  AVBY
//
//  Created by Арсений on 8.04.23.
//

import Foundation
import UIKit

class CarsService: NSObject {
    static var open = CarsService()
    private var arrayCars: [Car] = [
        Car(brand: "Mercedes",
            year: 2007,
            price: 15000,
            mileage: 265000,
            name: "W211 E320 CDI",
            volume: 3,
            horsePower: 224,
            gearBoxType: .automatic,
            color: "metalic",
            bodyType: .sedan,
            description: "Не бита, не крашена, 1 владелец, обслуживалась у официалов, пробег не смотан, как новая, сел и поехал, отдам почти бесплатно, звони!",
            engineType: .disel,
            ownerContacts: "+375291697223",
            photo: UIImage(named: "e320cdi")!),
    ]
    override init() {
        super.init()
    }
    
    func fetchArrayCars() -> [Car]{
        return arrayCars
    }
    func addCar(car: Car) {
        arrayCars.append(car)
    }
}
