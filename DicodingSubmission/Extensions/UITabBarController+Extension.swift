//
//  UITabBarController.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 25/09/21.
//

import Foundation
import SwiftUI

extension UITabBarController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        tabBar.standardAppearance = appearance
    }
}
