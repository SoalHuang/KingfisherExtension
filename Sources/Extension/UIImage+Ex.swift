//
//  UIImage+Ex.swift
//  KingfisherExtension
//
//  Created by soso on 2020/5/7.
//  Copyright © 2020 soso. All rights reserved.
//

import Foundation
import UIKit
import SDFoundation

extension UIImage {
    
    static func load(resource name: String) -> UIImage? {
        let imageName = "Frameworks/KingfisherExtension.framework/Resources.bundle/\(name)"
        return UIImage(named: imageName)
    }
    
}
