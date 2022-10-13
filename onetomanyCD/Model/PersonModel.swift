//
//  PersonModel.swift
//  onetomanyCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//

import Foundation

class Person{
    
    var id: UUID
    var name: String
    var Vehicle: [Vehicle]?
    
    init(id: UUID, name: String, Vehicle: [Vehicle]? = nil) {
        self.id = id
        self.name = name
        self.Vehicle = Vehicle
    }
}
