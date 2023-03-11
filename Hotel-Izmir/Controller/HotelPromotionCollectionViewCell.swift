//
//  HotelPromotionCollectionViewCell.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 10.03.2023.
//

import UIKit

class HotelPromotionCollectionViewCell: UICollectionViewCell {
    
    //MARK: OUTLETS
    @IBOutlet weak var roomImageView: UIImageView!
    @IBOutlet weak var roomNameLabel: UILabel!
    
    //MARK: PROPERTIES
    let identifierForPromotion: String = "hotelPromotionID"
    
    func setup(to promote: RoomTypeModel) {
        roomImageView.image = promote.roomImage
        roomNameLabel.text = promote.name
    }
}
