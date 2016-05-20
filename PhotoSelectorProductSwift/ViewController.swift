//
//  ViewController.swift
//  PhotoSelectorProductSwift
//
//  Created by 云族佳 on 16/4/22.
//  Copyright © 2016年 温仲斌. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
//        self.view.addSubview(popView)
        PopUpView.manager.getSelectImage { (selectImage) in
            self.image.image = selectImage
        }
        PopUpView.manager.getSelectImages { (selectImage) in
            print("\(selectImage)")
        }
        
        
    }
    @IBAction func show(sender: AnyObject) {
//        PopUpView.show()
        let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
        
        if UIApplication.sharedApplication().canOpenURL(url!) {
//            let url = NSURL.init(string: UIApplicationOpenSettingsURLString)
            UIApplication.sharedApplication().openURL(url!)
        }
    }

    @IBAction func dismiss(sender: AnyObject) {
        PopUpView.dismiss()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

