//
//  Singleton.swift
//  AVBY
//
//  Created by Арсений on 28.04.23.
//

import Foundation
public class Singleton {
    
    static let shared = Singleton()
   
    var vcShouldSuperSearch = false
    var arrayCars: [Car]?
    
}
