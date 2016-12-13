//
//  JDJellyButton.swift
//  JDJellyButton
//
//  Created by JamesDouble on 2016/12/9.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

//Author http://www.flaticon.com/authors/freepik

import UIKit

enum ExpandType {
    case Cross
}

protocol JDJellyButtonDataSource {
    func groupcount()->Int
    func imagesource(forgroup groupindex:Int) -> [UIImage]
}

class JelllyContainer:UIView
{
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    /*
     let the background totally transparent
     */
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        for subview in subviews {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                return true
            }
        }
        return false
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


class JDJellyButton
{
    //
    var MainButton:JDJellyMainButton!
    var Container:JelllyContainer!
    var RootView:UIView?
    var delegate:JellyButtonDelegate?
    var _datasource:JDJellyButtonDataSource?
 
    var datasource:JDJellyButtonDataSource?
    {
        get{
           return _datasource
        }
        set {
            self._datasource = newValue
            reloadData()
        }
    }

    //
    var buttonWidth:CGFloat = 40.0
    var buttonHeight:CGFloat = 40.0
    //
    
    init() {
       Container = JelllyContainer(frame: CGRect(x: 50, y: 50, width: 400, height: 400))
    }
    
    func reloadData()
    {
        cleanButtonGroup()
        addButtonGroup()
    }
    
    func attachtoView(rootView:UIView,mainbutton image:UIImage)
    {
        RootView = rootView
        let MainButtonFrame:CGRect = CGRect(x: 200 - 0.5 * buttonHeight, y: 200 - 0.5 * buttonHeight, width: buttonWidth, height: buttonHeight)
        MainButton = JDJellyMainButton(frame: MainButtonFrame, img: image, Parent: Container)
        MainButton.rootView = rootView
        MainButton.delegate = self
        Container.addSubview(MainButton)
        rootView.addSubview(Container)

    }
    
    func addButtonGroup()
    {
        let groupcount:Int = (_datasource?.groupcount())!
        for i in 0..<groupcount
        {
            var jellybuttons:[JDJellyButtonView] = [JDJellyButtonView]()
            let imgarr:[UIImage] = (_datasource?.imagesource(forgroup: i))!
            print("arrcount\(imgarr.count)")
            for img in imgarr
            {
                let MainButtonFrame:CGRect = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
                let jellybutton:JDJellyButtonView = JDJellyButtonView(frame: MainButtonFrame, bgimg: img)
                jellybutton.tapdelegate = self
                jellybuttons.append(jellybutton)
            }
            let jellybuttongroup:ButtonGroups = ButtonGroups(buttongroup: jellybuttons, groupPositionDiff: nil)
            MainButton.appendButtonGroup(bgs: jellybuttongroup)
        }
    }
    
    func cleanButtonGroup()
    {
        MainButton.closingButtonGroup(expandagain: false)
        MainButton.cleanButtonGroup()
    }
    
    func setJellyType(type:JellyButtonExpandType)
    {
        MainButton.setExpandType(type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}

extension JDJellyButton:MainButtonDelegate
{
    func MainButtonHasBeenTap(touch:UITouch)
    {
        let point = touch.location(in: RootView!)
        Container.frame.origin.x = point.x - 0.5 * self.Container.frame.width
        Container.frame.origin.y = point.y - 0.5 * self.Container.frame.height
    }
    
}

extension JDJellyButton:JellyButtonDelegate
{
    func JellyButtonHasBeenTap(touch:UITouch,image:UIImage,groupindex:Int,arrindex:Int)
    {
        delegate?.JellyButtonHasBeenTap(touch: touch, image: image, groupindex: groupindex, arrindex: arrindex)
    }
    
}
 



