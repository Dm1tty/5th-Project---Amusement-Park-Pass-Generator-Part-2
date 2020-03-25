//
//  Pass.swift
//  FifthProject
//
//  Created by Dzmitry Matsiulka on 8/4/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import Foundation

enum AreaAccess {
    case amusementPark
    case kitchen
    case rideControl
    case maintenance
    case office
}

enum RideAccess {
    case allRides
    case skipTheLines
    case noAccess
}

enum PassType: String{
    case basic
    case classic
    case vip
    case child
    case foodService
    case rideService
    case maintenance
    case manager
    case seasonPassholder
    case senior
    case contractor
    case vendor
}

class Pass {
    var areaAccess: [AreaAccess]
    var rideAccess: [RideAccess]
    var discountAccessFor: (food: Int, merchandise: Int)
    var passType: PassType
    var passName: String
    var lastSwipe: Date = Date()
    // customize all the initlizers
    init(passType: PassType, areaAccess: [AreaAccess], rideAccess: [RideAccess], discountAccessFor: (food: Int, merchandise: Int)) {
        self.passType = passType
        self.passName = passType.rawValue
        self.areaAccess = areaAccess
        self.rideAccess = rideAccess
        self.discountAccessFor = discountAccessFor
    }
}

class DefaultPass: Pass {
    init(){
        super.init(passType: .basic, areaAccess: [.amusementPark], rideAccess: [.allRides], discountAccessFor: (food: 0, merchandise: 0))
    }
}

/// Guest Passes --------------------------------------------
class GuestPass: Pass {
    init(passType: PassType, rideAccess: [RideAccess], discountAccessFor: (food: Int, merchandise: Int)){
        super.init(passType: passType, areaAccess: [AreaAccess.amusementPark], rideAccess: rideAccess, discountAccessFor: discountAccessFor)
    }
}

class ClassicPass: GuestPass {
    init(){
        super.init(passType: .classic, rideAccess: [.allRides], discountAccessFor: (food: 0, merchandise: 0))
    }
}

class VipPass: GuestPass {
    init(){
        super.init(passType: .vip, rideAccess: [.allRides, .skipTheLines], discountAccessFor: (food: 10, merchandise: 20))
    }
}

class ChildPass: GuestPass {
    //Pass only given if entrants age check passes
    init(){
        super.init(passType: .child, rideAccess: [.allRides], discountAccessFor: (food: 0, merchandise: 0))
    }
}

class SeasonPass: GuestPass {
    init(){
        super.init(passType: .seasonPassholder, rideAccess: [.allRides,.skipTheLines], discountAccessFor: (food: 10, merchandise: 20))
    }
}

class SeniorPass: GuestPass {
    init(){
        super.init(passType: .senior, rideAccess: [.allRides, .skipTheLines], discountAccessFor: (food: 10, merchandise: 20))
    }
}

///Employee Passes -------------------------------------------------
class EmployeePass: Pass {
    override init(passType: PassType, areaAccess: [AreaAccess], rideAccess:[RideAccess], discountAccessFor: (food: Int, merchandise: Int)){
        super.init(passType: passType, areaAccess: areaAccess, rideAccess: rideAccess, discountAccessFor: discountAccessFor)
    }
}

class HourlyEmployeePass: EmployeePass {
    init(passType: PassType, areaAccess: [AreaAccess], rideAccess: [RideAccess]){
        super.init(passType: passType, areaAccess: areaAccess, rideAccess: [.allRides], discountAccessFor: (food: 15, merchandise: 25))
    }
}

class FoodServicesPass: HourlyEmployeePass {
    init(){
        super.init(passType: .foodService, areaAccess: [.amusementPark,.kitchen], rideAccess: [.allRides])
    }
}

class RideServicesPass: HourlyEmployeePass {
    init(){
        super.init(passType: .rideService, areaAccess: [.amusementPark,.rideControl], rideAccess: [.allRides])
    }
}

class MaintenancePass: HourlyEmployeePass {
    init(){
        super.init(passType: .maintenance, areaAccess: [.amusementPark,.kitchen,.rideControl,.maintenance], rideAccess: [.allRides])
    }
}

class ManagerPass: EmployeePass {
    init(){
        super.init(passType: .manager, areaAccess: [.amusementPark,.kitchen,.rideControl,.maintenance,.office], rideAccess: [.allRides], discountAccessFor: (food: 25, merchandise: 25))
    }
}

class ContractorPass: EmployeePass {
    
    init(){
        super.init(passType: .contractor, areaAccess: [.amusementPark,.kitchen], rideAccess: [.noAccess], discountAccessFor: (food: 0, merchandise: 0))
    }
}

class VendorPass: EmployeePass {
    init(){
        super.init(passType: .vendor, areaAccess: [.amusementPark,.kitchen], rideAccess: [.noAccess], discountAccessFor: (food: 0, merchandise: 0))
    }
}



extension Pass {
    func passSummary(passName: Pass) -> String {
        switch passName.passType {
        case .basic: return
            """
            \u{2022} Unlimited Rides
            \u{2022} No Food Discount
            \u{2022} No Merchandise Discount
            """
        case .classic: return
            """
            \u{2022} Unlimited Rides
            \u{2022} No Food Discount
            \u{2022} No Merchandise Discount
            """
        case .vip: return
            """
            \u{2022} Unlimited Rides
            \u{2022} Skip Ride Lines
            \u{2022} 10% Food Discount
            \u{2022} 20% Merchandise Discount
            """
        case .child: return
            """
            \u{2022} Unlimited Rides
            \u{2022} No Food Discount
            \u{2022} No Merchandise Discount
            """
        case .foodService: return
            """
            \u{2022} Unlimited Rides
            \u{2022} 15% Food Discount
            \u{2022} 25% Merchandise Discount
            """
        case .rideService: return
            """
            \u{2022} Unlimited Rides
            \u{2022} 15% Food Discount
            \u{2022} 25% Merchandise Discount
            """
        case .maintenance: return
            """
            \u{2022} Unlimited Rides
            \u{2022} 15% Food Discount
            \u{2022} 25% Merchandise Discount
            """
        case .manager: return
            """
            \u{2022} Unlimited Rides
            \u{2022} 25% Food Discount
            \u{2022} 25% Merchandise Discount
            """
        case .seasonPassholder: return
            """
            \u{2022} Unlimited Rides
            \u{2022} Skip Ride Lines
            \u{2022} 10% Food Discount
            \u{2022} 20% Merchandise Discount
            """
        case .senior: return
            """
            \u{2022} Unlimited Rides
            \u{2022} Skip Ride Lines
            \u{2022} 10% Food Discount
            \u{2022} 10% Merchandise Discount
            """
        case .contractor: return
            """
            \u{2022} No Ride Access
            \u{2022} No Skipping lines
            \u{2022} No Food Discount
            \u{2022} No Merchandise Discount
            """
        case .vendor: return
            """
            \u{2022} No Ride Access
            \u{2022} No Skipping lines
            \u{2022} No Food Discount
            \u{2022} No Merchandise Discount
            """
        }
    }
}
