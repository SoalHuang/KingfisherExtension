//
//  KingfisherManager+Ex.swift
//  PTBlock
//
//  Created by SoalHunag on 2018/1/4.
//

import UIKit
import Kingfisher
import SDFoundation

public extension KingfisherManager {
    
    @discardableResult
    func retrieveImage(with url: String?, completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)? = nil) -> Kingfisher.DownloadTask? {
        guard let `url` = url, let link = URL(string: url) else {
            completionHandler?(.failure(.requestError(reason: .emptyRequest)))
            return nil
        }
        return retrieveImage(with: link, options: nil, progressBlock: nil, completionHandler: completionHandler)
    }
    
    @discardableResult
    func retrieveImage(with url: URL?, completionHandler: ((Result<Kingfisher.RetrieveImageResult, Kingfisher.KingfisherError>) -> Void)? = nil) -> Kingfisher.DownloadTask? {
        guard let `url` = url else {
            completionHandler?(.failure(.requestError(reason: .emptyRequest)))
            return nil
        }
        return retrieveImage(with: url, options: nil, progressBlock: nil, completionHandler: completionHandler)
    }
    
    func retrieveImage(with url: String?, size: CGSize, for mode: ContentMode = .aspectFill, completionHandler: ((Result<UIImage, Kingfisher.KingfisherError>) -> Void)? = nil) {
        guard let `url` = url, let link = URL(string: url) else {
            completionHandler?(.failure(.requestError(reason: .emptyRequest)))
            return
        }
        retrieveImage(with: link.sd.resize(Int(size.width), Int(size.height)), options: nil, progressBlock: nil) { [weak self] in
            
            switch $0 {
            case .success(let suc):
                completionHandler?(.success(suc.image))
            case .failure:
                self?.retrieveImage(with: link) {
                    switch $0 {
                    case .failure(let rerr):
                        completionHandler?(.failure(rerr))
                    case .success(let rsuc):
                        let image = rsuc.image
                        if image.size.width > size.width, image.size.height > size.height {
                            completionHandler?(.success(image.kf.resize(to: size, for: mode)))
                        } else {
                            completionHandler?(.success(rsuc.image))
                        }
                    }
                }
            }
        }
    }
}
