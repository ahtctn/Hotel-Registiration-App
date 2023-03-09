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
    
    static var allRoomTypes: [RoomTypeModel] {
        return [
            RoomTypeModel(id: 0, name: "Two Queens", shortName: "2QNS", price: 179),
            RoomTypeModel(id: 1, name: "One King", shortName: "1KNG", price: 209),
            RoomTypeModel(id: 2, name: "Suit", shortName: "SUI", price: 309)
        ]
    }
}


