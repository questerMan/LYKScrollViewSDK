//
//  ViewController.swift
//  Demo
//
//  Created by 陆遗坤 on 2020/6/15.
//  Copyright © 2020 陆遗坤. All rights reserved.
//

import UIKit
import LYKScrollViewSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let view = LYKManager.init().creatScrollView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 200),imageArray: [UIImage(named: "1.png")!,UIImage(named: "2.png")!])
        self.view.addSubview(view)
        
    }

    func getDefultImage(name:String) -> UIImage{
           
           let path = Bundle.main.resourcePath ?? ""

           let bundle = Bundle(path: path + "/Demo.bundle")
           
           print("路径：\( String(describing: Bundle.main.path(forResource: "LYKScrollViewSDK", ofType: "bundle", inDirectory: nil)))")
           if let currentBundle = bundle{
               let imagePath = "\(currentBundle.resourcePath!)/\(name)"
               return UIImage(contentsOfFile: imagePath)!
           }else{
               print("文件路径（\(String(describing: bundle?.resourcePath!))）找不到文件")
               return UIImage()
           }
       }
}

