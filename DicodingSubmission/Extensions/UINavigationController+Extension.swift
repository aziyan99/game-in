//
//  UINavigationController+Extension.swift
//  DicodingSubmission
//
//  Created by Raja Azian on 25/09/21.
//

import Foundation
import SwiftUI

extension UINavigationController {
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
