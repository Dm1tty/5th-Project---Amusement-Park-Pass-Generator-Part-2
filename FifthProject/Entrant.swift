//
//  Entrant.swift
//  FifthProject
//
//  Created by Dzmitry Matsiulka on 8/4/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import Foundation

enum EntrantType {
    case classic
    case vip
    case child
    case foodService
    case rideService
    case maintenance
    case manager
    case seasonPassHolder
    case senior
    case contracted
    case vendor
    case defaultEntrant
}

class Entrant {
    
    var entrantType: EntrantType
    let firstName: String?
    let lastName: String?
    var dateOfBirth: Date?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: String?
    let kiosk = Kiosk()
    var pass: Pass = DefaultPass()
    
    init(entrantType: EntrantType,
         firstName: String? = nil,
         lastName: String? = nil,
         dateOfBirth: Date? = nil,
         streetAddress: String? = nil,
         city: String? = nil,
         state: String? = nil,
         zipCode: String? = nil) {
        self.entrantType = entrantType
        self.firstName = firstName
        self.lastName = lastName
        self.dateOfBirth = dateOfBirth
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}
//---- Guests ------------------------------------------
class Guest: Entrant {
}

class ClassicGuest: Guest {
    init() {
        super.init(entrantType: .classic)
        pass = ClassicPass()
    }
}

class VipGuest: Guest {
    init() {
        super.init(entrantType: .vip)
        pass = VipPass()
    }
}

class ChildGuest: Guest {
    init(dateOfBirth: Date?) throws {
        super.init(entrantType: .child, dateOfBirth: dateOfBirth)
        try dateOfBirthCheck()
        guard let dob = dateOfBirth else{return}
        try validateChildPass(dateOfBirth: dob)
        pass = ChildPass()
    }
}

class SeasonPassHolder: Guest {
    init(firstName: String, lastName: String, streetAddress: String?, city: String?, state: String?, zipCode: String?) throws {
        super.init(entrantType: .seasonPassHolder, firstName: firstName, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        //must have required information
        try personalInfoCheck()
        try addressCheck()
        //create the pass if no errors
        pass = SeasonPass()
    }
}

class SeniorGuest: Guest {
    init(firstName: String, lastName: String, dateOfBirth: Date?) throws {
        super.init(entrantType: .senior, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth)
        try personalInfoCheck()
        try dateOfBirthCheck()
        pass =  SeniorPass()
    }
}

//---Employees--------------------------------------------
class Employee: Entrant {}

class HourlyEmployee: Employee {}

class FoodServicesEmployee: HourlyEmployee {
    init(firstname: String, lastName: String, streetAddress: String?, city: String?, state: String?, zipCode: String?) throws {
        super.init(entrantType: .foodService, firstName: firstname, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        try personalInfoCheck()
        try addressCheck()
        pass = FoodServicesPass()
    }
}

class RideServicesEmployee: HourlyEmployee {
    init(firstname: String, lastName: String, streetAddress: String?, city: String?, state: String?, zipCode: String?) throws {
        super.init(entrantType: .rideService, firstName: firstname, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        try personalInfoCheck()
        try addressCheck()
        pass = RideServicesPass()
    }
}

class MaintenanceEmployee: HourlyEmployee {
    init(firstname: String, lastName: String, streetAddress: String?, city: String?, state: String?, zipCode: String?) throws {
        super.init(entrantType: .maintenance, firstName: firstname, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        try personalInfoCheck()
        try addressCheck()
        pass = MaintenancePass()
    }
}

class Manager: Employee {
    init(firstname: String, lastName: String, streetAddress: String?, city: String?, state: String?, zipCode: String?) throws {
        super.init(entrantType: .manager, firstName: firstname, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        try personalInfoCheck()
        try addressCheck()
        pass = ManagerPass()
    }
}

class Contractor: Employee {
    let projectNumber: String?
    init(firstname: String, lastName: String, streetAddress: String?, city: String?, state: String?, zipCode: String?, projectNumber: String?) throws {
        self.projectNumber = projectNumber
        super.init(entrantType: .contracted, firstName: firstname, lastName: lastName, streetAddress: streetAddress, city: city, state: state, zipCode: zipCode)
        try personalInfoCheck()
        try addressCheck()
        try validateProjectNumber(projectNumber)
        pass = ContractorPass()
    }
}

class Vendor: Employee {
    let companyName: String?
    let serviceDate: String
    let dateOfVisit: Date?
    init(firstName:String, lastName:String, dateOfBirth:
        Date?, companyName: String?, serviceDate: String, dateOfVisit: Date?) throws {
        self.companyName = companyName
        self.dateOfVisit = dateOfVisit
        self.serviceDate = serviceDate
        super.init(entrantType: .vendor, firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth)
        try personalInfoCheck()
        try validateVendor(companyName)
        try dateOfServiceCheck(dateOfVisit)
        try validateDate(serviceDate)
        try dateOfBirthCheck()
        pass = VendorPass()
    }
}


