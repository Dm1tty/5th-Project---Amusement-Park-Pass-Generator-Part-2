//
//  PassCreatorViewController.swift
//  FifthProject
//
//  Created by Dzmitry Matsiulka on 8/4/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import UIKit

class PassCreatorViewController: UITableViewController {
    
    // Variables that are passed from the first viewcontroller
    var entrantName: String = "Default Name"
    var birthDate: String?
    var entrant = Entrant(entrantType: .defaultEntrant)
    let kiosk = Kiosk()
    var discountToCheck = String()
    var projectNumber = String()
    var companyName = String()
    var optionPressed = 0
  
    // Labels
    @IBOutlet weak var entrantNameLabel: UILabel!
    @IBOutlet weak var passTypeLabel: UILabel!
    @IBOutlet weak var passSummaryLabel: UILabel!
    @IBOutlet weak var testResultLabel: UILabel!
   
    // Buttons
    @IBOutlet var discountButtons: [UIButton]!
    @IBOutlet weak var discountAccessButton: UIButton!
    @IBOutlet var rideAccessButtons: [UIButton]!
    @IBOutlet var areaAccessButtons: [UIButton]!
   
    // Stacks
    @IBOutlet weak var rideAccessStack: UIStackView!
    @IBOutlet weak var areaAccessStack: UIStackView!
    @IBOutlet weak var discountAccessStack: UIStackView!
    @IBOutlet weak var discountOptionsStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideStacks()
        entrantNameLabel.text = entrantName
        passTypeLabel.text = "\(entrant.pass.passType.rawValue) pass"
        passSummaryLabel.text = entrant.pass.passSummary(passName: entrant.pass)
    }
    
    func swipeCheck() {
        do{
            try entrant.kiosk.doubleSwipeCheck(lastSwipe: entrant.pass.lastSwipe)
            
            //If it works update the date
            entrant.pass.lastSwipe = Date()
            
        } catch let error {
            let alert = UIAlertController(title: title , message:error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
  
    @IBAction func areaAccess(_ sender: UIButton) {
        hideStacks()
        areaAccessStack.isHidden = false
        if !(sender.currentTitle == "Area Access"){
            if !(optionPressed == 0){
                swipeCheck()
            } else {
                optionPressed += 1
            }
        } else {
            optionPressed = 0
        }
        var areaAccessArray : [AreaAccess] = []
        if entrant.pass.passName == "contractor" {
            return  areaAccessArray = ContractorPass().validateContractorAccess(projectNumber: projectNumber)
        }
        else if entrant.pass.passName == "vendor" {
            areaAccessArray = VendorPass().validateVendorAccess(companyName: companyName)
        }
        if entrant.pass.passName == "contractor" || entrant.pass.passName == "vendor" {
            switch sender.currentTitle {
            case "Amusment Park": testResultLabel.text = kiosk.validateAccess(pass: entrant.pass, areaAccessArray: areaAccessArray, at: .amusementPark)
            case "Kitchen": testResultLabel.text = kiosk.validateAccess(pass: entrant.pass, areaAccessArray: areaAccessArray, at: .kitchen)
            case "Ride Control": testResultLabel.text = kiosk.validateAccess(pass: entrant.pass, areaAccessArray: areaAccessArray, at: .rideControl)
            case "Maintenance": testResultLabel.text = kiosk.validateAccess(pass: entrant.pass, areaAccessArray: areaAccessArray, at: .maintenance)
            case "Office": testResultLabel.text = kiosk.validateAccess(pass: entrant.pass, areaAccessArray: areaAccessArray, at: .office)
            default: return
            }
        }
        else {
            switch sender.currentTitle {
            case "Amusment Park": testResultLabel.text =  kiosk.validateAccess(pass: entrant.pass, at: .amusementPark)
            case "Kitchen": testResultLabel.text =  kiosk.validateAccess(pass: entrant.pass, at: .kitchen)
            case "Ride Control": testResultLabel.text =  kiosk.validateAccess(pass: entrant.pass, at: .rideControl)
            case "Maintenance": testResultLabel.text =  kiosk.validateAccess(pass: entrant.pass, at: .maintenance)
            case "Office": testResultLabel.text =  kiosk.validateAccess(pass: entrant.pass, at: .office)
            default: return
            }
        }
    }
    
    @IBAction func rideAccess(_ sender: UIButton) {
        if !(sender.currentTitle == "Ride Access"){
            if !(optionPressed == 0){
                swipeCheck()
            } else {
                optionPressed += 1
            }
        } else {
            optionPressed = 0
        }
        hideStacks()
        rideAccessStack.isHidden = false
        switch sender.currentTitle {
        case "All Rides": testResultLabel.text = kiosk.validateAccess(pass: entrant.pass, at: .allRides)
        case "Skip Lines": testResultLabel.text = kiosk.validateAccess(pass: entrant.pass, at: .skipTheLines)
        default: return
        }
    }
    
    func hideStacks(){
        areaAccessStack.isHidden = true
        discountAccessStack.isHidden = true
        rideAccessStack.isHidden = true
        discountOptionsStack.isHidden = true
        discountAccessStack.isHidden = true
    }
    
    @IBAction func discountButton(_ sender: UIButton) {
        hideStacks()
        discountOptionsStack.isHidden = false
        optionPressed = 0
    }
    @IBAction func FoodDiscount(_ sender: UIButton) {
        hideStacks()
        discountAccessStack.isHidden = false
        discountToCheck = "Food Discount"
    }
    
    @IBAction func MerchandiseDiscount(_ sender: UIButton) {
        hideStacks()
        discountAccessStack.isHidden = false
        discountToCheck = "Merchandise Discount"
    }
    
    @IBAction func discountAccess(_ sender: UIButton) {
        if !(optionPressed == 0){
            swipeCheck()
        } else {
            optionPressed += 1
        }
        switch sender.currentTitle {
        case "0":
            testResultLabel.text = kiosk.validateAccess(discountToCheck: discountToCheck, pass: entrant.pass, discount: 0)
        case "10":
            testResultLabel.text = kiosk.validateAccess(discountToCheck: discountToCheck, pass: entrant.pass, discount: 10)
        case "15":
            testResultLabel.text = kiosk.validateAccess(discountToCheck: discountToCheck, pass: entrant.pass, discount: 15)
        case "20":
            testResultLabel.text = kiosk.validateAccess(discountToCheck: discountToCheck, pass: entrant.pass, discount: 20)
        case "25":
            testResultLabel.text = kiosk.validateAccess(discountToCheck: discountToCheck, pass: entrant.pass, discount: 25)
        default: testResultLabel.text = "Select A Discount"
        }
    }
    
    @IBAction func dismissVC(_ sender: Any) {
        //dismiss(animated: true, completion: nil) other way
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
}
