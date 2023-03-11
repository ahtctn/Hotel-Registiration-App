//
//  ContactViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 10.03.2023.
//

import UIKit
import SafariServices
import MessageUI


protocol ContactViewControllerCollectionViewDelegate: AnyObject {
    func didSelect(roomType: RoomTypeModel)
}

class ExploreViewController: UIViewController, MFMailComposeViewControllerDelegate {

    //MARK: OUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var phoneButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var instagramButton: UIButton!
    
    //MARK: PROPERTIES
    let socialMedias = ["https://www.instagram.com/allymationes", "https://www.twitter.com/aliDevJourney"]
    
    let identifierForPromotion: String = "hotelPromotionID"
    let storyboardID: String = "RoomDetailViewController"
    
    var hotelsToPromote: RoomTypeModel? 
    var hotelPromotionCollectionViewCell: HotelPromotionCollectionViewCell?
    
    var roomTypes = [RoomTypeModel]()
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        cornerRadiusForButtons()
        
    }
    
    //MARK: FUNCTIONS
    func cornerRadiusForButtons(){
        phoneButton.layer.cornerRadius = 10.0
        twitterButton.layer.cornerRadius = 10.0
        mailButton.layer.cornerRadius = 10.0
        instagramButton.layer.cornerRadius = 10.0
    }
    
    
    //MARK: ACTIONS
    @IBAction func instagramButtonTapped(_ button: UIButton) {
        if let url = URL(string: socialMedias[0]) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
        }
    }
    
    @IBAction func twitterButtonTapped(_ button: UIButton) {
        if let url = URL(string: socialMedias[1]) {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true)
        }
    }
    
    @IBAction func mailButtonTapped(_ button: UIButton) {
        //Simulator üzerinden mail atmak mümkün olmadığından dolayı, öncelikle uygulamanın açıldığı cihazın mail atmaya uygun olmadığına bakılması gerekiyor.
        guard MFMailComposeViewController.canSendMail() else { return }
        let mailComposer = MFMailComposeViewController()
        mailComposer.mailComposeDelegate = self
        mailComposer.setToRecipients(["ahtctn@gmail.com"])
        mailComposer.setCcRecipients(["erkansevm528@gmail.com"])
        mailComposer.setSubject("Uygulamanızla Alaklı Görüşlerim...")
        mailComposer.setMessageBody("Merhaba uygulamanızı ilgiyle kullanıyorum, telefondan görüşmemiz mümkün müdür acaba çünkü sizlere 100 mülyor trilyor dolar bağış yapmayı düşünüyorum da...", isHTML: true)
        present(mailComposer, animated: true)
    }
    
    
    
    
}

extension ExploreViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return RoomTypeModel.allRoomTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifierForPromotion, for: indexPath) as! HotelPromotionCollectionViewCell
        let roomImage = cell.roomImageView
        
        cell.setup(to: RoomTypeModel.allRoomTypes[indexPath.row])
        roomImage?.layer.cornerRadius = (roomImage?.frame.size.width)! / 15
        roomImage?.clipsToBounds = true
        roomImage?.layer.borderColor = UIColor.white.cgColor
        roomImage?.layer.borderWidth = 1
        return cell
    }
    
    
}

extension ExploreViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}

extension ExploreViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: storyboardID) as? RoomDetailViewController
        vc?.nameProperty = roomTypes[indexPath.row].name
        vc?.shortName = roomTypes[indexPath.row].shortName
        vc?.roomImageProperty = roomTypes[indexPath.row].roomImage
        vc?.roomDescription.text = roomTypes[indexPath.row].description
        vc?.price1 = roomTypes[indexPath.row].price
        vc?.price2 = roomTypes[indexPath.row].price
        vc?.price3 = roomTypes[indexPath.row].price
        vc?.hasHotWaterProperty = roomTypes[indexPath.row].hasHotWater
        
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}


