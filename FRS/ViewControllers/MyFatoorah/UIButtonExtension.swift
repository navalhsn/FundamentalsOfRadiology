//
//  UIButtonExtension.swift
//  MFSDKDemo-Swift
//
//  Created by Elsayed Hussein on 8/29/19.
//  Copyright © 2019 Elsayed Hussein. All rights reserved.
//

import UIKit

extension UIButton {
    open override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
}
