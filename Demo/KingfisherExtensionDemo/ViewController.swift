//
//  ViewController.swift
//  KingfisherExtensionDemo
//
//  Created by soso on 2020/2/25.
//  Copyright © 2020 soso. All rights reserved.
//

import UIKit
import KingfisherExtension

class ViewController: UIViewController {

    @IBOutlet private weak var imageView: UIImageView!
    
    @IBOutlet private weak var button: UIButton!
    
    @IBOutlet private weak var imageView2: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // failure loading
          imageView.loadImage(url: nil)
        
        // success loading
        imageView.loadImage(url: URL(string: "http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1212/10/c1/16491670_1355126816487.jpg"))
        
        imageView2.loadImage(url:  URL(string: ""), showLoading: true)

        button.setImage(url: URL(string: "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582628339332&di=68dc3d47bb7149361995516db948865e&imgtype=0&src=http%3A%2F%2Ffile.market.xiaomi.com%2Fthumbnail%2FPNG%2Fl114%2FAppStore%2F04da0579dc32dae60d3f1478b47a356b226432107"), for: .normal)
        button.setBackgroundImage(url: URL(string: "https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=164897972,3447451561&fm=26&gp=0.jpg"), for: .normal)
    }


}

