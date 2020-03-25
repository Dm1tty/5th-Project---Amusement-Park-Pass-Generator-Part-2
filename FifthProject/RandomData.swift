//
//  RandomData.swift
//  FifthProject
//
//  Created by Dzmitry Matsiulka on 8/4/19.
//  Copyright © 2019 Dzmitry M. All rights reserved.
//

import GameKit
import Foundation

func randomName() -> [String] {
    let firstName: [String] = [
        "Mike",
        "Roman",
        "Zayn",
        "Vicky",
        "Ryan",
        "Rana",
        "Alex",
        "Bryan"]
    
    let lastName:[String] = [
        "Dunckle",
        "White",
        "Black",
        "Shawn",
        "Orel",
        "Runkle",
        "Burny",
        "Hoper",
        "Lee",
    ]
    let first = firstName.shuffled()
    let last = lastName.shuffled()
    return [first[0], last[0]]
}
func randomProjectNumber() -> String {
    let randomNumber = Int.random(in: 1000...9999)
    return String(randomNumber)
}
func randomDate() -> String {
    let month = Int.random(in: 1...12)
    var day = 0
    switch month {
    case 1,3,5,7,8,10,12: day = Int.random(in: 1...31)
    case 2: day = Int.random(in: 1...28)
    default: day = Int.random(in: 1...30)
    }
    let components = DateComponents(year:2019, month: month, day:day)
    let calendar = Calendar(identifier: .gregorian)
    guard let date = calendar.date(from: components) else {return ""}
    let formatter = DateFormatter()
    formatter.dateFormat = "MM/dd/yyyy"
    let formattedText = formatter.string(from: date)
    return formattedText
}

func randomAddress()->[String]{
    return [
        "\(Int.random(in: 0 ..< 100)) Street Road",
        "random city \(Int.random(in: 0 ..< 100))",
        "random state \(Int.random(in: 0 ..< 100))",
        "\(Int.random(in: 10000 ..< 99999))"]
}

func randomCompanyName() -> String {
    let vendorNames = [ "Google","McDonald's","Fedex","Amazon","Smart Solutions","Treehouse" ]
    let randomIndex = Int.random(in: 0...vendorNames.count - 1)
    return vendorNames[randomIndex]
}

