//
//  Config.swift
//  PTResourceCaches
//
//  Created by soso on 2019/9/10.
//  Copyright © 2019 soso. All rights reserved.
//

import Foundation

private let logQueue = DispatchQueue(label: "com.sd.kingfisher.extension.log.queue")

func PTLog<T>(_ message: T,
                        file: String = #file,
                        line: Int = #line,
                        method: String = #function) {
    logQueue.async {
        print("[KingfisherExtension] [\((file as NSString).lastPathComponent) line: \(line), method: \(method)]: \(message)\n")
    }
}

