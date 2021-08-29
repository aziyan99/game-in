//
//  Float+Extension.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 29/08/21.
//

import Foundation


extension Float {
    var clean: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
