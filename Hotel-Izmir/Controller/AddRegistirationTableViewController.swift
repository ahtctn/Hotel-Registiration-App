//
//  AddRegistirationTableViewController.swift
//  Hotel-Izmir
//
//  Created by Ahmet Ali ÇETİN on 8.03.2023.
//

import UIKit

class AddRegistirationTableViewController: UITableViewController {
    
    //MARK: OUTLETS
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: FUNCTIONS
    
    
    //MARK: ACTIONS
    @IBAction func doneBarButtonTapped(_ button: UIBarButtonItem) {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let email = emailTextField.text!
        
        print("First Name: \(firstName)\nLast Name: \(lastName)\nEmail: \(email)")
    }

}
