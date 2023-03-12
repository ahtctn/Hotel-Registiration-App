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
            RoomTypeModel(id: 0, roomImage: UIImage(named: "twoQueens")!, name: "Two Queens", shortName: "2QNS", description: "Two Queens is the perfect choice for an economical and comfortable choice for your stay. Our Two Queens room awaits you with a nice stay, a quality bed, clean sheets and pillows! Thank you for choosing our economical and comfortable Two Queens room!", price: 179, hasHotWater: false),
            RoomTypeModel(id: 1, roomImage: UIImage(named: "oneKing")!, name: "One King", shortName: "1KNG", description: "One King is the perfect choice for an economical and comfortable choice for your stay! Our One King room awaits you with a nice stay, a quality bed, clean sheets and pillows. Thank you for choosing our economical and comfortable One King room!", price: 209, hasHotWater: true),
            RoomTypeModel(id: 2, roomImage: UIImage(named: "suit")!, name: "Suit", shortName: "SUI",description: "Our Suite room is the perfect choice for both an extremely luxurious and comfortable choice for your stay! Our Suite room is waiting for you as an extremely luxurious room with a nice accommodation process, a quality bed, clean sheets and pillows. Thank you for choosing our economical and comfortable Suite room!", price: 309, hasHotWater: false),
            RoomTypeModel(id: 3, roomImage: UIImage(named: "twoKing")!, name: "Two King" , shortName: "2KNG", description: "Our Two King room is the perfect choice for both an extremely luxurious and comfortable choice for your stay! Our Two King room is waiting for you as an extremely luxurious room with a nice accommodation process, a quality bed, clean sheets and pillows. Thank you for choosing our economical and comfortable Two King room!", price: 510, hasHotWater: true),
            RoomTypeModel(id: 4, roomImage: UIImage(named: "lux")!, name: "Luxury", shortName: "LUX", description: "Our Luxury room is the perfect choice for both an extremely luxurious and comfortable choice for your stay! Our Luxury room is waiting for you as an extremely luxurious room with a nice accommodation process, a quality bed, clean sheets and pillows. Thank you for choosing our economical and comfortable Luxury room!", price: 1000, hasHotWater: true)
        ]
    }
    
    func roomNameWithShortVersion() -> String {
        return "\(name) - \(shortName)"
    }
}


