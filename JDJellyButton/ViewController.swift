//
//  ViewController.swift
//  JDJellyButton
//
//  Created by waninuser on 2016/12/9.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button:JDJellyButton!
    @IBOutlet weak var exampleimg: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    let images:[UIImage] = [UIImage(named: "badoo")!,UIImage(named: "behance")!,UIImage(named: "deviantart")!]
    let images2:[UIImage] = [UIImage(named: "dribbble")!,UIImage(named: "facebook")!,UIImage(named: "flickr")!]
    let images3:[UIImage] = [UIImage(named: "google-plus")!,UIImage(named: "instagram")!,UIImage(named: "lastfm")!,UIImage(named: "linkedin")!]
    var imagearr:[[UIImage]] = [[UIImage]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imagearr.append(images)
        imagearr.append(images2)
        imagearr.append(images3)
        
        
        button = JDJellyButton()
        button.attachtoView(rootView: self.view)
        button.delegate = self
        button.datasource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:JellyButtonDelegate
{
    func JellyButtonHasBeenTap(touch:UITouch,image:UIImage,groupindex:Int,arrindex:Int)
    {
        self.exampleimg.image = image
        label1.text = "Group Index:\(groupindex)"
        label2.text = "ArrIndex\(arrindex)"
    }
    
}

extension ViewController:JDJellyButtonDataSource
{
    func groupcount()->Int
    {
    return 3
    }
    func imagesource(forgroup groupindex:Int) -> [UIImage]
    {
    return imagearr[groupindex]
    }
}

