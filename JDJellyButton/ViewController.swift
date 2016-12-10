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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        button = JDJellyButton()
        button.attachtoView(rootView: self.view)
        button.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ViewController:JellyButtonDelegate
{
    func JellyButtonHasBeenTap(touch:UITouch,image:UIImage)
    {
        self.exampleimg.image = image
    }
}

