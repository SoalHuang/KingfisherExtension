//
//  KingfisherExtension.swift
//  KingfisherExtension
//
//  Created by soso on 2020/2/25.
//  Copyright © 2020 soso. All rights reserved.
//

import UIKit

public class KingfisherExtensionManager {
    
    public static let manager = KingfisherExtensionManager()
    
    public var failedImage: UIImage? = UIImage.load(resource: "img_pic_loading_fail")
    
    public var loadingImages: [UIImage] = (1...10).compactMap { UIImage.load(resource: String(format: "ani_piece_loading_%0.2i", $0)) }
}
