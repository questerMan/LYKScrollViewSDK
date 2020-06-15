//
//  LYKManager.swift
//  LYKScrollViewSDK
//
//  Created by 陆遗坤 on 2020/6/15.
//  Copyright © 2020 陆遗坤. All rights reserved.
//

import UIKit

public class LYKManager: UIView {
    
    public func creatScrollView(frame: CGRect ,imageArray:Array<UIImage>) -> UIView{
        let scrollView = LYKAutoScrollView.init(frame: frame, dataSoures: imageArray)

        return scrollView
    }
    
    
   

}
