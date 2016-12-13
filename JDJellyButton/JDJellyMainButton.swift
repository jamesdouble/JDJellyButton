//
//  JDJellyMainButton.swift
//  JDJellyButton
//
//  Created by 郭介騵 on 2016/12/10.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

import UIKit

enum JellyButtonExpandType
{
    case Cross
    case LeftLine
    case RightLine
    case UpperLine
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
    var rootView:UIView?
    var ExpandType:JellyButtonExpandType = .Cross
    var ContainerView:UIView?
    var buttongroups:[ButtonGroups] = [ButtonGroups]()
    var Expanding:Bool = false
    var animating:Bool = false
    var Moving:Bool = false
    var expandignMove:Bool = false
    var LastPoint:CGPoint?
    var LastTime:TimeInterval?
    var radius:CGFloat = 30.0
    var halfWidth:CGFloat = 0.0
    var GroupIndex:Int = 0
    var x:[CGFloat] = [CGFloat]()
    var y:[CGFloat] = [CGFloat]()
    
    var delegate:MainButtonDelegate?
    
    init(frame: CGRect,BGColor:UIColor,Parent:UIView)  {
        super.init(frame:frame,BGColor:BGColor)
        self.ContainerView = Parent
        halfWidth = self.frame.width * 0.5
        caculateJellyPosition()
    }
    
    init(frame: CGRect,img:UIImage,Parent:UIView)  {
        super.init(frame: frame, bgimg: img)
        self.ContainerView = Parent
         halfWidth = self.frame.width * 0.5
        caculateJellyPosition()
    }
    
    func setExpandType(type:JellyButtonExpandType)
    {
        self.ExpandType = type
        caculateJellyPosition()
        updateJellyPosition()
        self.closingButtonGroup(expandagain: true)
    }
    
    func cleanButtonGroup()
    {
        buttongroups = [ButtonGroups]()
    }
    
    func getGroupIndex() -> Int
    {
        return GroupIndex
    }
    
    func getJellyButtonIndex(jelly:JDJellyButtonView) -> Int
    {
        var index = 0
        let nowgroup:ButtonGroups = buttongroups[GroupIndex]
        let buttongroup = nowgroup.buttongroup
        for jellybutton in buttongroup!
        {
                if(jellybutton.imgView == jelly.imgView)
                {
                    return index
                }
            index += 1
        }
        return index
    }
    
    func caculateJellyPosition()
    {
        x = [CGFloat]()
        y = [CGFloat]()
        if(ExpandType == .Cross)
        {
        x = [-(halfWidth + radius),0 ,halfWidth + radius,0]
        y = [0,-(halfWidth + radius),0 ,halfWidth + radius]
        }
        else if(ExpandType == .LeftLine)
        {
            for i in 1..<8
            {
                x.append(-(halfWidth + radius) * CGFloat(i))
                y.append(0.0)
            }
        }
        else if(ExpandType == .RightLine)
        {
            for i in 1..<8
            {
                x.append((halfWidth + radius) * CGFloat(i))
                y.append(0.0)
            }
        }
        else if(ExpandType == .UpperLine)
        {
            for i in 1..<8
            {
                y.append(-(halfWidth + radius) * CGFloat(i))
                x.append(0.0)
            }
        }
    }
    
    func updateJellyPosition()
    {
        var index:Int = 0
        for bg in buttongroups
        {
            var temp_bgs:ButtonGroups = bg
            temp_bgs.groupPositionDiff?.removeAll()
            for i in 0..<bg.buttongroup.count
            {
            temp_bgs.groupPositionDiff?.append(CGPoint(x: x[i], y: y[i]))
            }
            buttongroups[index] = temp_bgs
            index += 1
        }

    }
    
    func appendButtonGroup(bgs:ButtonGroups)
    {
        var temp_bgs:ButtonGroups = bgs
        for jelly in temp_bgs.buttongroup
        {
            jelly.dependingMainButton = self
        }
        temp_bgs.groupPositionDiff = [CGPoint]()
        
        for i in 0..<bgs.buttongroup.count
        {
            let cgpoint:CGPoint = CGPoint(x: x[i] , y: y[i])
            temp_bgs.groupPositionDiff?.append(cgpoint)
        }
        buttongroups.append(temp_bgs)
    }
    
    func switchButtonGroup()
    {
        
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
                    self.ContainerView!.addSubview(jellybutton)
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
    
    func closingButtonGroup(expandagain:Bool)
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
                        if(expandagain)
                        {
                        self.expandButtonGroup()
                        }
                    })
                    
                    index += 1
                }
            }
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
        LastPoint = touches.first?.location(in: self.rootView!)
        let transform = CGAffineTransform(scaleX: 0.8, y: 0.8);
        self.transform = transform
        
        if(animating)
        {
            LastTime = nil
            return
        }
        
        if(Expanding)
        {
            expandignMove = true
            closingButtonGroup(expandagain: false)
        }
        
        LastTime = touches.first!.timestamp
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let nowPoint:CGPoint = (touches.first?.location(in: self.rootView!))!
        let diffx = nowPoint.x - (LastPoint?.x)!
        let diffy = nowPoint.y - (LastPoint?.y)!
        let distance = sqrt(Double(diffx * diffx) + Double(diffy * diffy))
        if(distance > 10.0)
        {
            Moving = true
        }
        
        
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
                closingButtonGroup(expandagain: false)
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
        /*
         if(Expanding)
         {
         return
         }
         */
        let touch = touches.first!
        delegate?.MainButtonHasBeenTap(touch: touch)
    }
    
}




