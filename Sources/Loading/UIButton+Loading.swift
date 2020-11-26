//
//  UIButton+Loading.swift
//  Bloks
//
//  Created by SoalHunag on 2018/10/27.
//  Copyright © 2018 soso. All rights reserved.
//

import UIKit
import Kingfisher

public protocol ButtonImageLoadingable: Loadingable {
    
    func cancelLoadImage()
    
    func setImage(url: URL?,
                  for state: UIControl.State,
                  showLoading: Bool,
                  placeholderImage: UIImage?,
                  failedImage: UIImage?,
                  options: [KingfisherOptionsInfoItem],
                  completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)?)
    
    func setBackgroundImage(url: URL?,
                            for state: UIControl.State,
                            showLoading: Bool,
                            placeholderImage: UIImage?,
                            failedImage: UIImage?,
                            options: [KingfisherOptionsInfoItem],
                            completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)?)
}

extension UIButton: ButtonImageLoadingable {
    
    public func cancelLoadImage() {
        cancelLoading()
        kf.cancelImageDownloadTask()
    }
    
    public func setImage(url: URL?,
                         for state: UIControl.State,
                         showLoading: Bool = true,
                         placeholderImage: UIImage? = nil,
                         failedImage: UIImage? = KingfisherExtensionManager.manager.failedImage,
                         options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.2))],
                         completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)? = nil) {
        if showLoading, image(for: state) == nil {
            readyForLoading()
        }
        
        kf.setImage(with: url, for: state, placeholder: placeholderImage, options: options, progressBlock: { [weak self] (current, total) in
            self?.beganLoading(current, total)
        }) { [weak self] in
            switch $0 {
            case .failure(let err):
                PTLog("button load image image: \(err.localizedDescription)")
                self?.endedLoading(isSuccess: false, failedImage: failedImage)
                completionHandler?(.failure(err))
            case .success(let suc):
                self?.endedLoading()
                completionHandler?(.success(suc))
            }
        }
    }
    
    public func setBackgroundImage(url: URL?,
                                   for state: UIControl.State,
                                   showLoading: Bool = true,
                                   placeholderImage: UIImage? = nil,
                                   failedImage: UIImage? = KingfisherExtensionManager.manager.failedImage,
                                   options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.2))],
                                   completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)? = nil) {
        
        if showLoading, backgroundImage(for: state) == nil {
            readyForLoading()
        }
        
        kf.setBackgroundImage(with: url, for: state, placeholder: placeholderImage, options: options, progressBlock: { [weak self] (current, total) in
            self?.beganLoading(current, total)
        }) { [weak self] in
            switch $0 {
            case .failure(let err):
                PTLog("button load background image: \(err.localizedDescription)")
                self?.endedLoading(isSuccess: false, failedImage: failedImage)
                completionHandler?(.failure(err))
            case .success(let suc):
                self?.endedLoading()
                completionHandler?(.success(suc))
            }
        }
    }
}
