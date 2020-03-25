//
//  ErrorInspector.swift
//  FifthProject
//
//  Created by Dzmitry Matsiulka on 8/4/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import Foundation
import UIKit

enum EntrantErrors: Error {
    
    // Child Entrant Errors
    case exceededAge
    case futureKid
    case HappyBirthday(String)
    
    // Required personl Info
    case dateOfBirthMissing
    case missingFirstName
    case missingLastName
    case invalidDate
    
    // Required address
    case missingStreetName
    case missingCityName
    case missingStateName
    case missingZipCode
    case invalidZipCodeLength
    case invalidZipCodeText
    
    // Vendor errors
    case missingServiceDate
    case missingCompanyName
    case vendorNameMissing
    case invalidVendorName
    
    // Project errors
    case projectNumberInvalid
    case projectNumberMissing
    case invalidProjectNumberLength
    
    
    case accessError
}


extension EntrantErrors: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .exceededAge:
            return "Entrants age exceeds the age permitted to qualify for a free child pass.\n"
        case .futureKid:
            return "Future children do not qualify for a free child pass.\n"
        case .dateOfBirthMissing:
            return "Entrants date of birth is required for entry.\n"
        case .missingFirstName:
            return "Entrants first Name is required for entry.\n"
        case .missingLastName:
            return "Entrants last name is required for entry.\n"
        case .missingStreetName:
            return "Entrants street is required for entry.\n"
        case .missingCityName:
            return "Entrants city is required for entry.\n"
        case .missingStateName:
            return "Entrants state is required for entry.\n"
        case .missingZipCode:
            return "Entrants zipcode is required for entry.\n"
        case .missingServiceDate:
            return "Vendors date of service is required for entry.\n"
        case .missingCompanyName:
            return "Vendors company Name is required for entry.\n"
        case .projectNumberMissing:
            return "Project number is needed for entry.\n"
        case.projectNumberInvalid:
            return "Could not validate project number.\n"
        case .invalidProjectNumberLength:
            return "Project number does not meet the required length.\n"
        case .vendorNameMissing:
            return "Vendors name is required for entry.\n"
        case .invalidVendorName:
            return "Could not validate this vendor.\n"
        case .invalidDate:
            return "Date Must Be in the format MM/DD/YYYY.\n"
            
        // Additional alerts
        case .HappyBirthday(let name):
            return ("Happy Birthday \(name)!")
        case .invalidZipCodeLength:
            return "Zip code must be 5 digits."
        case .invalidZipCodeText:
            return "Zip Code must not contain leters."
        case .accessError :
            return "Due to an system error program can not check Access."
        }
    }
}

