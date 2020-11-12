//
//  UIButton+Resource.swift
//  KingfisherExtension
//
//  Created by soso on 2020/2/28.
//  Copyright © 2020 soso. All rights reserved.
//

import UIKit

public extension UIButton {
    
    func set(image resource: ImageResource,
             for state: UIControl.State = .normal,
             showLoading: Bool = true,
             placeholderImage: UIImage? = nil,
             failedImage: UIImage? = nil) {
        switch resource {
        case .target(let image):
            setImage(image ?? failedImage, for: state)
        case .name(let name):
            if !name.isEmpty {
                setImage(UIImage(named: name), for: state)
            } else {
                setImage(failedImage, for: state)
            }
        case .path(let path):
            if !path.isEmpty {
                setImage(UIImage(contentsOfFile: path), for: state)
            } else {
                setImage(failedImage, for: state)
            }
        case .url(let url):
            setImage(url: url, for: state, showLoading: showLoading, placeholderImage: placeholderImage, failedImage: failedImage)
        }
    }
    
    func setBackground(image resource: ImageResource,
                       for state: UIControl.State = .normal,
                       showLoading: Bool = true,
                       placeholderImage: UIImage? = nil,
                       failedImage: UIImage? = nil) {
        switch resource {
        case .target(let image):
            setBackgroundImage(image ?? failedImage, for: state)
        case .name(let name):
            if !name.isEmpty {
                setBackgroundImage(UIImage(named: name), for: state)
            } else {
                setBackgroundImage(failedImage, for: state)
            }
        case .path(let path):
            if !path.isEmpty {
                setBackgroundImage(UIImage(contentsOfFile: path), for: state)
            } else {
                setBackgroundImage(failedImage, for: state)
            }
        case .url(let url):
            setBackgroundImage(url: url, for: state, showLoading: showLoading, placeholderImage: placeholderImage, failedImage: failedImage)
        }
    }
}
