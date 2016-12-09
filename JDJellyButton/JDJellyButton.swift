//
//  JDJellyButton.swift
//  JDJellyButton
//
//  Created by waninuser on 2016/12/9.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

//Author http://www.flaticon.com/authors/freepik

import UIKit

enum ExpandType {
    case Cross
}

class JDJellyButton
{
    //
    var MainButton:JDJellyMainButton!
    var Container:UIView!
    var RootView:UIView?
    //
    var buttonWidth:CGFloat = 40.0
    var buttonHeight:CGFloat = 40.0

    
    init() {
       Container = UIView(frame: CGRect(x: 50, y: 50, width: 200, height: 200))
    }
    
    func attachtoView(rootView:UIView)
    {
        RootView = rootView
        let MainButtonFrame:CGRect = CGRect(x: 80, y: 80, width: buttonWidth, height: buttonHeight)
        //MainButton = JDJellyMainButton(frame: MainButtonFrame,BGColor: UIColor.red,Parent: Container)
        MainButton = JDJellyMainButton(frame: MainButtonFrame, img: UIImage(named:"vk")!, Parent: Container)
        MainButton.delegate = self
        Container.addSubview(MainButton)
        rootView.addSubview(Container)
        addExampleGroup()
    }
    
    func addButtonGroup(images:[UIImage])
    {
        var jellybuttons:[JDJellyButtonView] = [JDJellyButtonView]()
        for img in images
        {
            let MainButtonFrame:CGRect = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
            let jellybutton:JDJellyButtonView = JDJellyButtonView(frame: MainButtonFrame, bgimg: img)
            jellybuttons.append(jellybutton)
        }
        let jellybuttongroup:ButtonGroups = ButtonGroups(buttongroup: jellybuttons, groupPositionDiff: nil)
        MainButton.appendButtonGroup(bgs: jellybuttongroup)
    }
    
    func addButtonGroup(colors:[UIColor])
    {
        var jellybuttons:[JDJellyButtonView] = [JDJellyButtonView]()
        for color in colors
        {
            let MainButtonFrame:CGRect = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
            let jellybutton:JDJellyButtonView = JDJellyButtonView(frame: MainButtonFrame, BGColor: color)
            jellybuttons.append(jellybutton)
        }
        let jellybuttongroup:ButtonGroups = ButtonGroups(buttongroup: jellybuttons, groupPositionDiff: nil)
        MainButton.appendButtonGroup(bgs: jellybuttongroup)
    }
    
    func cleanButtonGroup()
    {
        MainButton.closingButtonGroup()
        MainButton.cleanButtonGroup()
    }
    
    func addExampleGroup()
    {
        /*
        let colors:[UIColor] = [UIColor.black,UIColor.red]
        addButtonGroup(colors: colors)
        let colors2:[UIColor] = [UIColor.yellow]
        addButtonGroup(colors: colors2)
         */
        let images:[UIImage] = [UIImage(named: "badoo")!,UIImage(named: "behance")!,UIImage(named: "deviantart")!]
        addButtonGroup(images: images)
        let images2:[UIImage] = [UIImage(named: "dribbble")!,UIImage(named: "facebook")!,UIImage(named: "flickr")!]
        addButtonGroup(images: images2)
        
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



