//
//  CurrentDate+Helper.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 15/09/21.
//

import Foundation

func getCurrentDate() -> String {
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE d MMMM"
    let currentDate: String = dateFormatter.string(from: date)

    return currentDate
}
