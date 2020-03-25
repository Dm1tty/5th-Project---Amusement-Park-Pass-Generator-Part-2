//
//  Kiosk.swift
//  FifthProject
//
//  Created by Dzmitry Matsiulka on 8/4/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

enum KioskError{
    case doubleSwipe
}

extension KioskError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .doubleSwipe: return "Your pass was already swiped"
        }
    }
}


class Kiosk {
    let soundPlayer = Sounds()
    
    func doubleSwipeCheck(lastSwipe: Date) throws {
        let passedTime = Calendar.current.dateComponents([.second], from: lastSwipe, to: Date())
        if let second = passedTime.second {
            if second < 5 {
                throw KioskError.doubleSwipe
            }
        }
    }
    
    func validateAccess(pass: Pass, at area: AreaAccess) -> String {
        if pass.areaAccess.contains(area) {
            soundPlayer.playSound(soundName: "AccessGranted")
            return ("\(pass.passName) pass - You have access to the \(area) area\n")
        }else {
            soundPlayer.playSound(soundName: "AccessDenied")
            return ("\(pass.passName) pass - Access Denied: You do not have access to the \(area) area\n")
        }
    }
    
    func validateAccess(pass: Pass, areaAccessArray: [AreaAccess], at area: AreaAccess) -> String {
        if areaAccessArray.contains(area){
            soundPlayer.playSound(soundName: "AccessGranted")
            return ("\(pass.passName) pass - You have access to the \(area) area\n")
        }else {
            soundPlayer.playSound(soundName: "AccessDenied")
            return ("\(pass.passName) pass - Access Denied: You do not have access to the \(area) area\n")
        }
    }
    
    func validateAccess(pass: Pass, at ride: RideAccess) -> String {
        switch ride {
        case .allRides:
            if pass.rideAccess == [.noAccess] || !(pass.rideAccess.contains(ride)) {
                soundPlayer.playSound(soundName: "AccessDenied")
                return ("\(pass.passName) pass - Access Denied: You do not have access to the rides\n")
            } else {
                soundPlayer.playSound(soundName: "AccessGranted")
                return ("\(pass.passName) pass - Access Granted: You have access to all rides \n")
            }
        case .skipTheLines:
            if pass.rideAccess == [.noAccess] || !(pass.rideAccess.contains(ride)){
                soundPlayer.playSound(soundName: "AccessDenied")
                return ("\(pass.passName) pass - Access Denied: You do not have access to skip the lines for rides\n")
            }else {
                soundPlayer.playSound(soundName: "AccessGranted")
                return ("\(pass.passName) pass - Access Granted: You can skip ride lines.\n")
            }
        default: return "Error Try Again"
        }
    }
    
    func validateAccess(discountToCheck: String?, pass: Pass, discount: Int) -> String {
        if let discountToCheck = discountToCheck {
            switch discountToCheck {
            case "Food Discount":
                if pass.discountAccessFor.food == discount {
                    soundPlayer.playSound(soundName: "AccessGranted")
                    return ("\(pass.passName) pass - Access Granted: You qualify for a food discount of \(discount)%\n")
                }else {
                    soundPlayer.playSound(soundName: "AccessDenied")
                    return ("\(pass.passName) pass - Access Denied: You do not qualify for a food discount of \(discount)%\n")
                }
            case "Merchandise Discount":
                if pass.discountAccessFor.merchandise == discount {
                    soundPlayer.playSound(soundName: "AccessGranted")
                    return ("\(pass.passName) pass - Access Granted: You qualify for a merchandise discount of \(discount)%\n")
                }else {
                    soundPlayer.playSound(soundName: "AccessDenied")
                    return ("\(pass.passName) pass - Access Denied: You do not qualify for a merchandise discount of \(discount)%\n")
                }
            default: return "Discount does not exist"
            }}
        return ""
    }
}
