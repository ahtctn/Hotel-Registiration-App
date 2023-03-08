//
//  RoomTypeModel.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 8.03.2023.
//

import Foundation

struct RoomTypeModel: Equatable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static func == (lhs: RoomTypeModel, rhs: RoomTypeModel) -> Bool {
        return lhs.id == rhs.id
    }
}
