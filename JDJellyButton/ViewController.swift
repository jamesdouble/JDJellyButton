//
//  ViewController.swift
//  JDJellyButton
//
//  Created by JamesDouble on 2016/12/9.
//  Copyright © 2016年 jamesdouble. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    var button:JDJellyButton!
    @IBOutlet weak var exampleimg: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    let images:[UIImage] = [UIImage(named: "badoo")!,UIImage(named: "behance")!,UIImage(named: "deviantart")!]
    let images2:[UIImage] = [UIImage(named: "dribbble")!,UIImage(named: "facebook")!,UIImage(named: "flickr")!]
    let images3:[UIImage] = [UIImage(named: "google-plus")!,UIImage(named: "instagram")!,UIImage(named: "lastfm")!,UIImage(named: "linkedin")!]
    var imagearr:[[UIImage]] = [[UIImage]]()
    
    let titlestr:[String] = ["Cross","Left","Right","Upper"]
    let typerow:[JellyButtonExpandType] =   [.Cross,.LeftLine,.RightLine,.UpperLine]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        imagearr.append(images)
        imagearr.append(images2)
        imagearr.append(images3)
        
        picker.delegate = self
        picker.dataSource = self
        
        
        button = JDJellyButton()
        button.attachtoView(rootView: self.view,mainbutton: UIImage(named:"vk")!)
        button.delegate = self
        button.datasource = self
        button.setJellyType(type: .Cross)
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

extension ViewController:UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return titlestr.count
    }
}

extension ViewController:UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?
    {
        let strings:NSAttributedString = NSAttributedString(string: titlestr[row], attributes: [NSForegroundColorAttributeName:UIColor.white])
        return strings
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        button.setJellyType(type: typerow[row])
    }
}


