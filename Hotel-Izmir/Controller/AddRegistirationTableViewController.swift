//
//  AddRegistirationTableViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 8.03.2023.
//

import UIKit

class AddRegistirationTableViewController: UITableViewController, SelectRoomTypeTableViewControllerDelegate {
    
    //MARK: OUTLETS
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var checkInDatePicker: UIDatePicker!
    @IBOutlet weak var checkOutDatePicker: UIDatePicker!
    @IBOutlet weak var checkInDateLabel: UILabel!
    @IBOutlet weak var checkOutDateLabel: UILabel!
    
    @IBOutlet weak var numberOfAdultsLabel: UILabel!
    @IBOutlet weak var numberOfChildrenLabel: UILabel!

    @IBOutlet weak var numberOfAdultsStepper: UIStepper!
    @IBOutlet weak var numberOfChildrenStepper: UIStepper!
    
    @IBOutlet weak var wifiSwitch: UISwitch!
    
    @IBOutlet weak var roomTypeLabel: UILabel!
    
    //MARK: PROPERTIES
    let checkInDateLabelCellIndexPath = IndexPath(row: 0, section: 1)
    let checkInDatePickerCellIndexPath = IndexPath(row: 1, section: 1)
    
    let checkOutDateLabelCellIndexPath = IndexPath(row: 2, section: 1)
    let checkOutDatePickerCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isCheckInDatePickerShown: Bool = false {
        didSet {
            checkInDateLabel.isHidden = !isCheckInDatePickerShown
        }
    }
    
    var isCheckOutDatePickerShown: Bool = false {
        didSet {
            checkOutDateLabel.isHidden = !isCheckOutDatePickerShown
        }
    }
    
    var roomType: RoomTypeModel?
    var registiration: RegistirationModel? {
        guard let roomType = roomType else { return nil }
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        let checkInDate = checkInDatePicker.date
        let checkOutDate = checkInDatePicker.date
        let numberOfAdults = Int(numberOfAdultsStepper.value)
        let numberOfChildren = Int(numberOfChildrenStepper.value)
        let hasWifi = wifiSwitch.isOn
        
        return RegistirationModel(firstName: firstName, lastName: lastName, emailAdress: email, checkInDate: checkInDate, checkOutDate: checkOutDate, numberOfChildren: numberOfChildren, numberOfAdults: numberOfAdults, roomType: roomType, wifi: hasWifi)
    }
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateStartingSettings()
        updateNumberOfCustomers()
        updateDateViews()
        updateRoomType()
    }
    
    //MARK: FUNCTIONS
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "selectRoomType" {
            let destination = segue.destination as? SelectRoomTypeTableViewController
            destination?.delegate = self
            destination?.selectedRoomType = roomType
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath {
        case checkInDatePickerCellIndexPath:
            if isCheckInDatePickerShown {
                return 216
            } else {
                return 0
            }
        case checkOutDatePickerCellIndexPath:
            if isCheckOutDatePickerShown {
                return 216
            } else {
                return 0
                
            }
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //Seçili olan hücrenin seçili olma durumunu sonlandırır.
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath {
        case checkInDateLabelCellIndexPath:
            if isCheckInDatePickerShown {
                isCheckInDatePickerShown = false
            } else if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
                isCheckInDatePickerShown = true
            } else {
                isCheckInDatePickerShown = true
            }
            //Değişkenlerdeki değişim ile birlikte, heightForRow fonksiyonu yeniden çalıştırılır.
            //Fakat yükseklik değişimleri animasyon ile sağlanır.
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case checkOutDateLabelCellIndexPath:
            if isCheckOutDatePickerShown {
                isCheckOutDatePickerShown = false
            } else if isCheckInDatePickerShown {
                isCheckOutDatePickerShown = true
                isCheckInDatePickerShown = false
            } else {
                isCheckOutDatePickerShown = true
            }
            
            tableView.beginUpdates()
            tableView.endUpdates()
        default:
            break
        }
        
    }
    
    func dateStartingSettings() {
        let midnightToday = Calendar.current.startOfDay(for: Date())
        checkInDatePicker.minimumDate = midnightToday
        checkInDatePicker.date = midnightToday
    }
    
    func updateDateViews() {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        checkInDateLabel.text = dateFormatter.string(from: checkInDatePicker.date)
        checkOutDateLabel.text = dateFormatter.string(from: checkOutDatePicker.date)
        let oneDay = 24 * 60 * 60
        checkOutDatePicker.minimumDate = checkInDatePicker.date.addingTimeInterval(Double(oneDay))
        
    }
    
    func updateNumberOfCustomers() {
        numberOfAdultsLabel.text = String(format: "%0.f", numberOfAdultsStepper.value)
        numberOfChildrenLabel.text = String(format: "%0.f", numberOfChildrenStepper.value)
    }
    
    func updateRoomType() {
        if let roomType = roomType {
            roomTypeLabel.text = roomType.name
        } else {
            roomTypeLabel.text = "Not Set"
        }
    }
    
    func didSelect(roomType: RoomTypeModel) {
        self.roomType = roomType
        updateRoomType()
    }
    
    //MARK: ACTIONS
    @IBAction func doneBarButtonTapped(_ button: UIBarButtonItem) {
        print(registiration)
    }
    
    @IBAction func datePickerValueChanged(_ picker: UIDatePicker) {
        updateDateViews()
    }
    
    @IBAction func stepperValueChanged(_ stepper: UIStepper) {
        updateNumberOfCustomers()
    }
    
    @IBAction func wifiSwitchChanged (_ sender: UISwitch) {
        
    }

}
