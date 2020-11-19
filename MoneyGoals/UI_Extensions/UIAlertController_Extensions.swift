//
//  UIAlertController_Extensions.swift
//  MoneyGoals
//
//  Created by Bruce Beuzard IV on 10/16/20.
//

import UIKit

extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
