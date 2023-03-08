//
//  RegistirationModel.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 8.03.2023.
//

import Foundation

struct RegistirationModel {
    //MARK: PROPERTIES
    var firstName: String
    var lastName: String
    var emailAdress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    
    var numberOfChildren: Int
    var numberOfAdults: Int
    
    var roomType: RoomTypeModel
    var wifi: Bool
}
