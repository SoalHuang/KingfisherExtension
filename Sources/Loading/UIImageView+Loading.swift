//
//  UIImageView+Loading.swift
//  PTBlock
//
//  Created by soso on 2017/6/1.
//
//

import UIKit
import Kingfisher

public protocol ImageLoadingable: Loadingable {
    
    func cancelLoadImage()
    func loadImage(url: URL?,
                   showLoading: Bool,
                   placeholderImage: UIImage?,
                   failedImage: UIImage?,
                   options: [KingfisherOptionsInfoItem],
                   completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)?)
}

extension UIImageView: ImageLoadingable {
    
    public func cancelLoadImage() {
        cancelLoading()
        kf.cancelDownloadTask()
    }
    
    public func loadImage(url: URL?,
                          showLoading: Bool = true,
                          placeholderImage: UIImage? = nil,
                          failedImage: UIImage? = KingfisherExtensionManager.manager.failedImage,
                          options: [KingfisherOptionsInfoItem] = [.transition(.fade(0.2))],
                          completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)? = nil) {
        
        if showLoading {
            readyForLoading()
        }
        
        kf.setImage(with: url, placeholder: showLoading ? nil : placeholderImage, options: options, progressBlock: { [weak self] (current, total) in
            self?.beganLoading(current, total)
        }) { [weak self] in
            switch $0 {
            case .failure(let err):
                PTLog("load image: \(err.localizedDescription)")
                self?.endedLoading(isSuccess: false, failedImage: failedImage)
                completionHandler?(.failure(err))
            case .success(let suc):
                self?.endedLoading(isSuccess: true)
                completionHandler?(.success(suc))
            }
        }
    }
}
