//
//  RoomTypeModel.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 8.03.2023.
//

import UIKit

struct RoomTypeModel: Equatable {
    var id: Int
    var roomImage: UIImage
    var name: String
    var shortName: String
    var description: String
    var price: Int
    var hasHotWater: Bool
    
    static func == (lhs: RoomTypeModel, rhs: RoomTypeModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static var allRoomTypes: [RoomTypeModel] {
        return [
            RoomTypeModel(id: 0, roomImage: UIImage(named: "twoQueens")!, name: "Two Queens", shortName: "2QNS", description: "", price: 179, hasHotWater: true),
            RoomTypeModel(id: 1, roomImage: UIImage(named: "oneKing")!, name: "One King", shortName: "1KNG", description: "", price: 209, hasHotWater: true),
            RoomTypeModel(id: 2, roomImage: UIImage(named: "suit")!, name: "Suit", shortName: "SUI",description: "", price: 309, hasHotWater: false),
            RoomTypeModel(id: 3, roomImage: UIImage(named: "twoKing")!, name: "Two King" , shortName: "2KNG", description: "", price: 510, hasHotWater: true),
            RoomTypeModel(id: 4, roomImage: UIImage(named: "lux")!, name: "Luxury", shortName: "LUX", description: "", price: 1000, hasHotWater: true)
        ]
    }
}


