//
//  Loadingable.swift
//  KingfisherExtension
//
//  Created by soso on 2020/6/5.
//  Copyright © 2020 soso. All rights reserved.
//

import Foundation
import SDFoundation
import SDUIKit

public protocol Loadingable: ViewableType { }

private let LoadingAniamtionViewTag: Int = 0xDDDDDD
public extension ViewableType {
    
    var animationImageView: UIImageView? {
        get {
            return view.viewWithTag(LoadingAniamtionViewTag) as? UIImageView
        }
        set {
            if newValue == animationImageView { return }
            self.animationImageView?.removeFromSuper()
            guard let imageView = newValue else { return }
            
            view.addSubview(imageView)
            imageView.tag = LoadingAniamtionViewTag
            
            let width = max(min(min(view.bounds.width, view.bounds.height) * 0.35, 72.0), 18.0)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: width).isActive = true
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
    }
    
    func readyForLoading() {
        if animationImageView == nil {
            animationImageView = UIImageView()
            animationImageView?.contentMode = .scaleAspectFit
            animationImageView?.animationDuration = 1
            animationImageView?.animationImages = KingfisherExtensionManager.manager.loadingImages
        }
        guard let animationView = animationImageView else { return }
        if animationView.isAnimating { animationView.stopAnimating() }
        animationView.image = nil
        animationView.startAnimating()
    }
    
    func beganLoading(_ current: Int64, _ total: Int64) {
        if total == 0 { return }
        let p: Double = Double(current) / Double(total)
        if let imageView = animationImageView, imageView.isAnimating, p > 0.99 {
            imageView.stopAnimating()
        }
    }
    
    func endedLoading(isSuccess: Bool = true, failedImage: UIImage? = nil) {
        guard let animationView = animationImageView else { return }
        animationView.stopAnimating()
        guard isSuccess else {
            animationView.image = failedImage
            return
        }
        animationView.image = nil
        animationView.removeFromSuper()
    }
    
    func cancelLoading() {
        guard let animationView = animationImageView else { return }
        animationView.stopAnimating()
        animationView.image = nil
    }
}

