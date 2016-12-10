//
//  JDJellyButtonView.swift
//  JDJellyButton
//
//  Created by waninuser on 2016/12/9.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

import UIKit

 protocol JellyButtonDelegate {
    func JellyButtonHasBeenTap(touch:UITouch,image:UIImage)
}

extension JellyButtonDelegate{
    func JellyButtonHasBeenTap(touch:UITouch,image:UIImage)
      {
        
      }
}



class JDJellyButtonView:UIView
{
    var tapdelegate:JellyButtonDelegate?
    var imgView:UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect,BGColor:UIColor) {
        super.init(frame: frame)
       
        self.layer.cornerRadius = 0.4 * self.frame.width
        self.backgroundColor = BGColor
    }
    
    init(frame: CGRect,bgimg:UIImage) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 0.4 * self.frame.width
        imgView = UIImageView(image: bgimg)
        imgView?.frame = self.bounds
        self.addSubview(imgView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
       let image = self.imgView?.image
       tapdelegate?.JellyButtonHasBeenTap(touch: touches.first!,image: image!)
    }
    
    
}

