//
//  RoomDetailViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 11.03.2023.
//

import UIKit

class RoomDetailViewController: UIViewController {

    //MARK: OUTLETS
    @IBOutlet weak var roomImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var roomDescription: UITextView!
    @IBOutlet weak var priceLabel1: UILabel!
    @IBOutlet weak var priceLabel2: UILabel!
    @IBOutlet weak var priceLabel3: UILabel!
    @IBOutlet weak var hasHotWater: UILabel!
    
    //MARK: PROPERTIES
    var roomImageProperty: UIImage = UIImage(systemName: "person.fill")!
    var nameProperty: String = ""
    var shortName: String = ""
    var roomDescriptionProperty: String = ""
    var price1: Int = 0
    var price2: Int = 0
    var price3: Int = 0
    var hasHotWaterProperty: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateLabelsWithTheProperties() {
        roomImage.image = roomImageProperty
        name.text = "\(nameProperty)- \(shortName)"
        roomDescription.text = roomDescriptionProperty
        priceLabel1.text = "\(price1) ₺"
        priceLabel1.text = "\(price2) ₺"
        priceLabel1.text = "\(price3) ₺"
        if hasHotWaterProperty {
            hasHotWater.text = "Not: Sıcak su bulunmaktadır."
        } else {
            hasHotWater.text = "Not sıcak su bulunmamaktadır."
        }
    }
    //MARK: ACTIONS
    @IBAction func unwindFromExploreVC(unwindSegue: UIStoryboardSegue) {
        guard let source = unwindSegue.source as? ExploreViewController,
              let roomType = source. else { return }
        
    }
}
