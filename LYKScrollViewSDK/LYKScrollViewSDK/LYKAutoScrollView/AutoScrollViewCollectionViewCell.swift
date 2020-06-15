//
//  AutoScrollViewCollectionViewCell.swift
//  LYKAutoShow
//
//  Created by 陆遗坤 on 2020/5/31.
//  Copyright © 2020 陆遗坤. All rights reserved.
//

import UIKit

class AutoScrollViewCollectionViewCell: UICollectionViewCell {
    
    lazy var imageview:UIImageView = {
        let imageview = UIImageView.init(frame: self.bounds)
        imageview.contentMode = .scaleToFill
        return imageview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(imageview)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
         
        let bezierPath = UIBezierPath.init(roundedRect: self.imageview.bounds, cornerRadius: 10.0)
        let shapeLayer = CAShapeLayer.init()
        shapeLayer.frame = self.bounds
        shapeLayer.path = bezierPath.cgPath
        self.imageview.layer.mask = shapeLayer
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
