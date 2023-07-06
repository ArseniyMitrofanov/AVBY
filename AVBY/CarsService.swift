//
//  CarsService.swift
//  AVBY
//
//  Created by Арсений on 8.04.23.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage
protocol CarsServiceDelegate: NSObject {
    func didFetchCar()
    func didSaveCar()
}

class CarsService: NSObject {
    weak var delegate: CarsServiceDelegate?
    static var shared = CarsService()
    private var arrayCars: [Car] {
        didSet {
            delegate?.didFetchCar()
        }
    }

    override init() {
        self.arrayCars = [
            Car(brand: "Mercedes",
                year: 2007,
                price: 15000,
                mileage: 265000,
                name: "W211 E320 CDI",
                volume: 3,
                horsePower: 224,
                gearBoxType: GearBoxType.automatic,
                color: "metallic",
                bodyType: BodyType.sedan,
                description: "Не бита, не крашена, 1 владелец, обслуживалась у официалов, пробег не смотан, как новая, сел и поехал, отдам почти бесплатно, звони!",
                engineType: EngineType.disel,
                ownerContacts: "+375291697223",
                photo: UIImage(named: "e320cdi")!)
        ]
    }

    func fetchArrayCars() -> [Car]{
        return arrayCars
    }
    func addCar(car: Car) {
        arrayCars.append(car)
    }
    
    func postCar(car:Car) {
        //postImage
        let imageRef = Storage.storage().reference().child("pictures").child(UUID().uuidString)
        if let imageData = car.photo.jpegData(compressionQuality: 0.5) {
            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Failed to upload image: \(error)")
                } else {
                    if let metadata = metadata {
                        // Получите URL загруженного изображения
                        imageRef.downloadURL { [weak self] (url, error) in
                            if let error = error {
                                print("Failed to get download URL: \(error)")
                            } else if let downloadURL = url {
                                // Сохраните URL вместе с другими данными в базе данных
                                self?.postCarData(car: CarWithURL(brand: car.brand, year: car.year, price: car.price, mileage: car.mileage, name: car.name, volume: car.volume, horsePower: car.horsePower, gearBoxType: car.gearBoxType, color: car.color, bodyType: car.bodyType, description: car.description, engineType: car.engineType, ownerContacts: car.ownerContacts, photo: downloadURL.absoluteString))
                            }
                        }
                    }
                    
                }
            }
        }
    }
    
    func postCarData(car: CarWithURL) {
        let db = Firestore.firestore()
        let carsCollection = db.collection("cars")
        carsCollection.addDocument(data: [
            "brand": car.brand,
            "year": car.year,
            "price": car.price,
            "mileage": car.mileage,
            "name": car.name,
            "volume": car.volume,
            "horsePower": car.horsePower,
            "gearBoxType": car.gearBoxType,
            "color": car.color,
            "bodyType": car.bodyType,
            "description": car.description,
            "engineType": car.engineType,
            "ownerContacts": car.ownerContacts,
            "photo": car.photo,
        ]) { error in
            if let error = error {
                print("Failed to save car: \(error)")
            } else {
                print("Car saved successfully")
                self.delegate?.didSaveCar()
            }
        }
        
    }
    
    func getArrayCars() {
        self.arrayCars.removeAll()
        let db = Firestore.firestore()
        let carsCollection = db.collection("cars")

        carsCollection.getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Failed to fetch cars: \(error)")
            } else if let documents = querySnapshot?.documents {
                let cars = documents.compactMap { document -> Car? in
                    let data = document.data()
                    guard let brand = data["brand"] as? String,
                          let year = data["year"] as? Int,
                          let price = data["price"] as? Int,
                          let mileage = data["mileage"] as? Int,
                          let name = data["name"] as? String,
                          let volume = data["volume"] as? Double,
                          let horsePower = data["horsePower"] as? Int,
                          let gearBoxType = data["gearBoxType"] as? String,
                          let color = data["color"] as? String,
                          let bodyType = data["bodyType"] as? String,
                          let description = data["description"] as? String,
                          let engineType = data["engineType"] as? String,
                          let ownerContacts = data["ownerContacts"] as? String,
                          let photo = data["photo"] as? String else {
                        return nil
                    }
                    self.loadImage(from: photo, completion: {image in
                        if let image = image{
                            let car = Car(brand: brand, year: year, price: price, mileage: mileage, name: name, volume: volume, horsePower: horsePower, gearBoxType: gearBoxType, color: color, bodyType: bodyType, description: description, engineType: engineType, ownerContacts: ownerContacts, photo: image)
                            self.arrayCars.append(car)
                        }
                    })
                    return nil
                }
                print("mapEnded")
            }
        }
    }
    

    func loadImage(from imageURL: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Failed to download image: \(error)")
                completion(nil)
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }.resume()
    }

    
}
