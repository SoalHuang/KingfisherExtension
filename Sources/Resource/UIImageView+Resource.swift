//
//  UIImage+Resources.swift
//  KingfisherExtension
//
//  Created by soso on 2020/2/28.
//  Copyright © 2020 soso. All rights reserved.
//

import Foundation
import SDFoundation
import SDUIKit
import Kingfisher

public typealias ImageResource = SDFoundation.Resource<UIImage>

public extension UIImageView {
    
     func set(image resource: ImageResource,
             showLoading: Bool = true,
             placeholderImage: UIImage? = nil,
             failedImage: UIImage? = nil,
             completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)? = nil) {
        switch resource {
        case .target(let img):
            image = img
        case .name(let name):
            if !name.isEmpty {
                image = UIImage(named: name)
            } else {
                image = failedImage
            }
        case .path(let path):
            if !path.isEmpty {
                image = UIImage(contentsOfFile: path)
            } else {
                image = failedImage
            }
        case .url(let url):
            loadImage(url: url, showLoading: showLoading, placeholderImage: placeholderImage, failedImage: failedImage, completionHandler: completionHandler)
        }
    }
}



