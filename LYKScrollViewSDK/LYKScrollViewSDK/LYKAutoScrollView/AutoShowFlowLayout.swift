//
//  AutoShowFlowLayout.swift
//  LYKAutoShow
//
//  Created by 陆遗坤 on 2020/5/31.
//  Copyright © 2020 陆遗坤. All rights reserved.
//

import UIKit
import Foundation

class AutoShowFlowLayout: UICollectionViewFlowLayout {

    var isZoom:Bool = true
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes:Array<UICollectionViewLayoutAttributes> = NSArray(array: super.layoutAttributesForElements(in: rect) ?? NSArray.init() as!  [UICollectionViewLayoutAttributes], copyItems: true) as! Array<UICollectionViewLayoutAttributes>
        
        //let attributes = super.layoutAttributesForElements(in: rect)
        if !self.isZoom { return (attributes )}
        // 2.计算整体的中心点的x值
        let centerX:CGFloat = (self.collectionView?.contentOffset.x)! + (self.collectionView?.bounds.size.width)! * 0.5
        
        // 3.修改一下attributes对象
        for item in attributes{
            // 3.1 计算每个cell的中心点距离
            let distance:CGFloat = abs(item.center.x - centerX)
             // 3.2 距离越大，缩放比越小，距离越小，缩放比越大
            let factor:CGFloat = 0.001
            let scale = 1/(1+distance*factor+0.1)
            item.transform =  CGAffineTransform(scaleX: scale, y: scale)//CGAffineTransformMakeScale
        }

        return attributes
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
}
