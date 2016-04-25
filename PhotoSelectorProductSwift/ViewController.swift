//
//  ViewController.swift
//  PhotoSelectorProductSwift
//
//  Created by 云族佳 on 16/4/22.
//  Copyright © 2016年 温仲斌. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.groupTableViewBackgroundColor()
//        self.view.addSubview(popView)

        
        
        
    }
    @IBAction func show(sender: AnyObject) {
        PopUpView.show()
        PopUpView.manager.getSelectIndex { (selectIdx) in
            print("\(selectIdx)")
            PhotoAlbumMamager.sharedInstance.pushPhotoViewController(self.view)
            PopUpView.dismiss()
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

