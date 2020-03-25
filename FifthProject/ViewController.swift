//
//  ViewController.swift
//  FifthProject
//
//  Created by Dzmitry Matsiulka on 8/4/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    // Vars Initialization
    var segueStatus: Bool = false
    var firstName: String = String()
    var lastName: String = String()
    var passName: String = String()
    var dateOfBirth: Date? = Date()
    var entrant = Entrant(entrantType: .defaultEntrant)
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: String?
    
    // The very top row of buttons
    @IBOutlet var entrantOptionButtons: [UIButton]!
    
    // TextFields Outlets
    @IBOutlet var nameTextField: [UITextField]!
    @IBOutlet var addressTextField: [UITextField]!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet var vendorCompanyTextField: [UITextField]!
    @IBOutlet weak var projectNumberTextField: UITextField!
    
    // Stacks so the will be preventing the user from using extra fields
    @IBOutlet weak var employeeMenueStack: UIStackView!
    @IBOutlet weak var guestMenueStack: UIStackView!
    @IBOutlet weak var companyServiceDate: UIStackView!
    @IBOutlet weak var addressStack: UIStackView!
    @IBOutlet weak var companyStack: UIStackView!
    @IBOutlet weak var nameStack: UIStackView!
    @IBOutlet weak var ssnStack: UIStackView!
    @IBOutlet weak var projectNumberStack: UIStackView!
    @IBOutlet weak var dobStack: UIStackView!
    @IBOutlet weak var entrantInfoStack: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guestMenueStack.isHidden = true
        employeeMenueStack.isHidden = true
        companyServiceDate.isHidden = true
        
        // Blocks stacks until the user make a selection for a new pass
        disableStack(nameStack)
        disableStack(dobStack)
        disableStack(companyStack)
        disableStack(addressStack)
        disableStack(projectNumberStack)
        disableStack(ssnStack)
    
        
    }
    
    func disableStack(_ stackName: UIStackView){
        stackName.isUserInteractionEnabled = false
        stackName.alpha = 0.3
    }
    
    func enableStack(_ stackName: UIStackView){
        stackName.isUserInteractionEnabled = true
        stackName.alpha = 1
    }
    
    func showAlert(title: String, message: String){
        
        //If an alert is shown and the segue status is true then the "Continue" option will show.
        let alert = UIAlertController(title: title , message: message, preferredStyle: .alert)
        if segueStatus {
            alert.addAction(UIAlertAction(title: "Continue", style: .default, handler:{ action in
                self.performSegue(withIdentifier: "CreatePassSegue", sender: nil)
            }))
        } else {
            //if not an error needs to be addressed by the user
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        }
        //Must present the alert for the user to view it.
        self.present(alert, animated: true)
    }
    
    func customCatch(_ error: Error){
        if error.localizedDescription.contains("Happy Birthday") {
            segueStatus = true
            showAlert(title: "Happy Birthday!", message: error.localizedDescription)
        }else{
            showAlert(title: "Could Not Create Pass", message: error.localizedDescription)
            segueStatus = false
        }
    }
    
    func checkReqInfo() {
        switch passName {
        case "Classic":
            do {
                entrant = ClassicGuest()
                if let dateOfBirth = dateOfBirth {
                    try entrant.birthDayCheck(dateOfBirth: dateOfBirth)
                }
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "VIP":
            do {
                entrant = VipGuest()
                if let dateOfBirth = dateOfBirth {
                    try entrant.birthDayCheck(dateOfBirth: dateOfBirth)
                }
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "Child":
            do {
                entrant = try ChildGuest(dateOfBirth: dateOfBirth)
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
            
        case "Food Services":
            do {
                entrant = try FoodServicesEmployee(firstname: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
                if let dateOfBirth = dateOfBirth {
                    try entrant.birthDayCheck(dateOfBirth: dateOfBirth)
                }
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "Ride Services":
            do {
                entrant = try RideServicesEmployee(firstname: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
                if let dateOfBirth = dateOfBirth {
                    try entrant.birthDayCheck(dateOfBirth: dateOfBirth)
                }
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "Maintenance":
            do {
                entrant = try MaintenanceEmployee(firstname: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode )
                if let dateOfBirth = dateOfBirth {
                    try entrant.birthDayCheck(dateOfBirth: dateOfBirth)
                }
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "Manager":
            do {
                entrant = try Manager(firstname: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
                if let dateOfBirth = dateOfBirth {
                    try entrant.birthDayCheck(dateOfBirth: dateOfBirth)
                }
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "Season Pass":
            do {
                entrant = try SeasonPassHolder(firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
                if let dateOfBirth = dateOfBirth {
                    try entrant.birthDayCheck(dateOfBirth: dateOfBirth)
                }
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "Senior":
            do {
                entrant = try SeniorGuest(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth)
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "Contractor":
            do {
                var projectNumberString: String? = projectNumberTextField.text
                if projectNumberTextField.text == ""{
                    projectNumberString = nil
                }
                entrant = try Contractor(firstname: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode, projectNumber: projectNumberString)
                if let dateOfBirth = dateOfBirth {
                    try entrant.birthDayCheck(dateOfBirth: dateOfBirth)
                }
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        case "Vendor":
            var companyName: String? = vendorCompanyTextField[0].text
            if vendorCompanyTextField[0].text == "" {
                companyName = nil
            }
            guard let serviceDate = vendorCompanyTextField[1].text else {return}
            let dateOfVisit = Date.dateFromString(value: serviceDate)
            do {
                entrant = try Vendor(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth, companyName: companyName, serviceDate: serviceDate ,dateOfVisit: dateOfVisit)
                segueStatus = true
            } catch let error {
                customCatch(error)
            }
        default: return
        }
    }
    
    @IBAction func generatePass(_ sender: UIButton) {
        
        //reseting the status
        segueStatus = false
        
        //assign vars now that the user is ready to create a pass
        if let first = nameTextField[0].text, let last = nameTextField[1].text {
            firstName = first
            lastName = last
        } else { return }
        
        if let dob = dateOfBirthTextField.text{
           
            //Check for valid date before saving the date of birth
            do{
                try entrant.validateDate(dob)
            } catch let error {
                showAlert(title: "Could Not Create Pass", message: error.localizedDescription)
            }
            dateOfBirth = Date.dateFromString(value: dob)
        }
        streetAddress = addressTextField[0].text
        city = addressTextField[1].text
        state = addressTextField[2].text
        zipCode = addressTextField[3].text
        checkReqInfo()
        
        // If all requirements are met continue creating the pass.
        if segueStatus {
            performSegue(withIdentifier: "CreatePassSegue", sender: nil)
        }
    }
    
    func clearTextFields() {
        
        //reset all text fields when options are switched or when pass is created
        dateOfBirthTextField.text?.removeAll()
        projectNumberTextField.text?.removeAll()
        for textField in nameTextField {
            textField.text?.removeAll()
        }
        for textField in vendorCompanyTextField {
            textField.text?.removeAll()
        }
        for textField in addressTextField {
            textField.text?.removeAll()
        }
    }
    
    @IBAction func entrantOptionButtons(_ sender: UIButton) {
        guard let pass = sender.currentTitle else {return}
        clearTextFields()
        passName = pass
        guestMenueStack.isHidden = true
        employeeMenueStack.isHidden = true
        switch sender.tag {
        case 0: guestMenueStack.isHidden = false
        case 1: employeeMenueStack.isHidden = false
        default: return
        }
    }
    
    @IBAction func adjustInputOptions(_ sender: UIButton) {
        
        // Save the selected option as the pass's name
        guard let pass = sender.currentTitle else {return}
        passName = pass
       
        // Clean data
        clearTextFields()
        disableStack(nameStack)
        disableStack(companyStack)
        disableStack(addressStack)
        disableStack(projectNumberStack)
        disableStack(ssnStack)
        disableStack(projectNumberStack)
        companyServiceDate.isHidden = true
       
        // Every typee can submit a date of birth
        enableStack(dobStack)
        switch sender.tag {
        case 9:
            enableStack(nameStack)
        case 2,8,10,11,12:
            enableStack(nameStack)
            enableStack(addressStack)
        case 3:
            enableStack(nameStack)
            enableStack(addressStack)
            enableStack(projectNumberStack)
        case 4:
            enableStack(nameStack)
            enableStack(companyStack)
            companyServiceDate.isHidden = false
        default: return
        }
    }
    
    //This is ran before the segue is performed
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //check that the correct segue is being preformed.
        guard let destinationVC = segue.destination as? PassCreatorViewController else {return}
        //if so then pass all the needed variables.
        if !(firstName == "") {
            destinationVC.entrantName = "\(firstName) \(lastName)"
        }else{ destinationVC.entrantName = "New Entrant"}
        destinationVC.entrant = entrant
        if let pn = projectNumberTextField.text {
            destinationVC.projectNumber = pn
        }
        if let companyName = vendorCompanyTextField[0].text{
            destinationVC.companyName = companyName
        }
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {
        //reset the program
        clearTextFields()
        disableStack(dobStack)
        guestMenueStack.isHidden = true
        employeeMenueStack.isHidden = true
        disableStack(nameStack)
        disableStack(companyStack)
        disableStack(addressStack)
        disableStack(projectNumberStack)
        disableStack(ssnStack)
        disableStack(projectNumberStack)
    }
    
    @IBAction func populateData(_ sender: UIButton) {
        if dobStack.isUserInteractionEnabled{
            dateOfBirthTextField.text = randomDate()
        }
        if projectNumberStack.isUserInteractionEnabled {
            projectNumberTextField.text = randomProjectNumber()
        }
        if nameStack.isUserInteractionEnabled {
            let name = randomName()
            nameTextField[0].text = name[0]
            nameTextField[1].text = name[1]
        }
        if companyStack.isUserInteractionEnabled {
            vendorCompanyTextField[0].text = randomCompanyName()
            vendorCompanyTextField[1].text = randomDate()
        }
        if addressStack.isUserInteractionEnabled {
            let address = randomAddress()
            streetAddress = address[0]
            city = address[1]
            state = address[2]
            zipCode = address[3]
            addressTextField[0].text = streetAddress
            addressTextField[1].text = city
            addressTextField[2].text = state
            addressTextField[3].text = zipCode
        }
    }
}
