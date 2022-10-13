//
//  VehicleModel.swift
//  onetomanyCD
//
//  Created by Nathaniel Whittington on 9/24/22.
//

import Foundation

class Vehicle{
    
    var id: UUID
    var name: String
    var type: String
    var owner: String?
    
    init(id: UUID, name: String, type: String, owner: String? = nil) {
        self.id = id
        self.name = name
        self.type = type
        self.owner = owner
    }
}
