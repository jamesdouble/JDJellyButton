//
//  JDJellyButtonView.swift
//  JDJellyButton
//
//  Created by waninuser on 2016/12/9.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

import UIKit

class JDJellyButtonView:UIView
{
    
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
        let imgView:UIImageView = UIImageView(image: bgimg)
        imgView.frame = self.bounds
        self.addSubview(imgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
       print("Jelly~")
    }
    
    
}

struct ButtonGroups {
    var buttongroup:[JDJellyButtonView]!
    var groupPositionDiff:[CGPoint]?
}

protocol MainButtonDelegate {
    func MainButtonHasBeenTap(touch:UITouch)
}

class JDJellyMainButton:JDJellyButtonView
{
    var ParentView:UIView?
    var buttongroups:[ButtonGroups] = [ButtonGroups]()
    var Expanding:Bool = false
    var animating:Bool = false
    var Moving:Bool = false
    var expandignMove:Bool = false
    var LastPoint:CGPoint?
    var LastTime:TimeInterval?
    var radius:CGFloat = 30.0
    var GroupIndex:Int = 0

    var delegate:MainButtonDelegate?
    
    init(frame: CGRect,BGColor:UIColor,Parent:UIView)  {
        super.init(frame:frame,BGColor:BGColor)
        self.ParentView = Parent
    }
    
    init(frame: CGRect,img:UIImage,Parent:UIView)  {
        super.init(frame: frame, bgimg: img)
        self.ParentView = Parent
    }
    
    
    func cleanButtonGroup()
    {
       buttongroups = [ButtonGroups]()
    }
    
    func appendButtonGroup(bgs:ButtonGroups)
    {
        var temp_bgs:ButtonGroups = bgs
        temp_bgs.groupPositionDiff = [CGPoint]()
        let x:[CGFloat] = [-(0.5 * self.frame.width + radius),0 ,0.5 * self.frame.width + radius,0]
        let y:[CGFloat] = [0,-(0.5 * self.frame.width + radius),0 ,0.5 * self.frame.width + radius]
        for i in 0..<bgs.buttongroup.count
        {
            let cgpoint:CGPoint = CGPoint(x: x[i] , y: y[i])
            temp_bgs.groupPositionDiff?.append(cgpoint)
        }
        buttongroups.append(temp_bgs)
    }
    
    func switchButtonGroup()
    {
        print("animating:\(animating)")
        if(animating)
        {
            return
        }
        
        if((GroupIndex + 1) >= buttongroups.count)
        {
            GroupIndex = 0
        }
        else
        {
            GroupIndex += 1
        }
        expandButtonGroup()
    }
    
    func expandButtonGroup()
    {
        if(GroupIndex < buttongroups.count)
        {
            let nowgroup:ButtonGroups = buttongroups[GroupIndex]
            let buttongroup = nowgroup.buttongroup
            let diff = nowgroup.groupPositionDiff
            var index = 0
            if(!animating)
            {
                
                for jellybutton in buttongroup!
                {
                
                    animating = true
                    jellybutton.alpha = 0.0
                    jellybutton.frame = self.frame
                    self.ParentView!.addSubview(jellybutton)
                    UIView.animate(withDuration: 0.6, delay: 0.0, options: .curveEaseOut , animations: {
                        jellybutton.frame.origin.y +=  (diff?[index].y)!
                        jellybutton.frame.origin.x +=  (diff?[index].x)!
                        jellybutton.alpha = 1.0
                    }, completion:   { (value: Bool) in
                    self.animating = false
                    self.Expanding = true
                    })
                
                    index += 1
                }
            }
        }
    }
    
    func closingButtonGroup()
    {
        if(GroupIndex < buttongroups.count)
        {
            let nowgroup:ButtonGroups = buttongroups[GroupIndex]
            let buttongroup = nowgroup.buttongroup
            let diff = nowgroup.groupPositionDiff
            var index = 0
            if(!animating)
            {
                for jellybutton in buttongroup!
                {
                
                    animating = true
                    UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseOut , animations: {
                        jellybutton.frame.origin.y -=  (diff?[index].y)!
                        jellybutton.frame.origin.x -=  (diff?[index].x)!
                        jellybutton.alpha = 0.0
                        }, completion:   { (value: Bool) in
                            self.animating = false
                            self.Expanding = false
                            jellybutton.removeFromSuperview()
                    })
                
                    index += 1
                }
            }
        }
    }
    
    func stopingButtonGroup()
    {
        animating = false
        let nowgroup:ButtonGroups = buttongroups[GroupIndex]
        let buttongroup = nowgroup.buttongroup
        for jellybutton in buttongroup!
        {
            jellybutton.layer.removeAllAnimations()
        }
    }
    

    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JDJellyMainButton
{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
        self.transform = transform
        
        if(animating)
        {
            LastTime = nil
            return
        }
        
        print("Expanding\(Expanding)")
        if(Expanding)
        {
            expandignMove = true
            closingButtonGroup()
        }
        
        LastTime = touches.first!.timestamp
       
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if(LastTime == nil)
        {
            let transform = CGAffineTransform(scaleX: 1, y: 1);
            self.transform = transform

            return
        }
        
        let transform = CGAffineTransform(scaleX: 1, y: 1);
        self.transform = transform
        
        if(touches.first!.timestamp - LastTime! < 0.15)
        {
            if(!Expanding)
            {
                expandButtonGroup()
            }
            else
            {
                closingButtonGroup()
            }
            
        }
        else
        {
            if(!Moving)
            {
                switchButtonGroup()
            }
            if(expandignMove && Moving)
            {
                expandButtonGroup()
            }
        }
        Moving = false
        expandignMove = false
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        Moving = true
        let touch = touches.first!
        delegate?.MainButtonHasBeenTap(touch: touch)
    }

}



