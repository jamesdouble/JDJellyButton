# JDJellyButton

***
#Introduction

JDJellyButton is a highly-cutomization navigation Button.

You can manage your own button group. 

Of course, you can recive notification when the button has been tap by implements delegate.

Thanks for using.

![Alt text](/../master/Readme_img/JDJellyButtonDemo.gif?raw=true "")

###Button Image Source: http://www.flaticon.com/authors/freepik

***
##Switch Button Group
To Switch Button Group, you just need to hold on Mainbutton for 1.5 second.

![Alt text](/../master/Readme_img/change_group.gif?raw=true "")

#Usage

To add JellyButton to your view, you need to designate the attached view and the Main button image.

```Swift
button = JDJellyButton()
button.attachtoView(rootView: self.view,mainbutton: UIImage(named:"vk")!)
button.delegate = self  //Optional
button.datasource = self
```

###Important 
Also you need to implements the protocol JDJellyButtonDataSource ,designating your button group count and image array in specific group.

```Swift
let images:[UIImage] = [UIImage(named: "badoo")!,UIImage(named: "behance")!,UIImage(named: "deviantart")!]
let images2:[UIImage] = [UIImage(named: "dribbble")!,UIImage(named: "facebook")!,UIImage(named: "flickr")!]
let images3:[UIImage] = [UIImage(named: "google-plus")!,UIImage(named: "instagram")!,UIImage(named:"lastfm")!,UIImage(named: "linkedin")!]
var imagearr:[[UIImage]] = [[UIImage]]()

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
```
###Change Expanding Type
There're some button expanding type you can choose.
```Swift
/*
enum JellyButtonExpandType
{
    case Cross
    case LeftLine
    case RightLine
    case UpperLine
}
*/
button.setJellyType(type: .Cross)
```
![Alt text](/../master/Readme_img/change_type.gif?raw=true "")

###Delegate(Optional))
If you want to get notification when user tap one of buttons, you can implement JellyButtonDelegate 
```Swift
extension ViewController:JellyButtonDelegate
{
    func JellyButtonHasBeenTap(touch:UITouch,image:UIImage,groupindex:Int,arrindex:Int)
    {
        self.exampleimg.image = image
        label1.text = "Group Index:\(groupindex)"
        label2.text = "ArrIndex\(arrindex)"
    }
    
}
```
![Alt text](/../master/Readme_img/jellybutton_delegate.gif?raw=true "")

