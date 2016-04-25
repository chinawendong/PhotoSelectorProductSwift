//
//  PopUpView.swift
//  PhotoSelectorProductSwift
//
//  Created by 云族佳 on 16/4/22.
//  Copyright © 2016年 温仲斌. All rights reserved.
//

import UIKit

import AssetsLibrary

typealias SelectBlock = (selectIdx : Int)->Void

class PopUpView: UIView, UITableViewDelegate, UITableViewDataSource , UIGestureRecognizerDelegate {
    var tableView : UITableView?
    let titleArray = ["拍照", "从相册中选择","取消"]
    static let manager = PopUpView.init(frame: UIScreen.mainScreen().bounds)
    var photoArray = [AnyObject]()
    var selectBlock : SelectBlock?
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
        self.tableView = UITableView.init(frame: frame, style: UITableViewStyle.Plain)
        tableView!.delegate = self;
        tableView!.dataSource = self;
        tableView!.registerNib(UINib.init(nibName: "HerdViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableView!.registerNib(UINib.init(nibName: "ButtonCell", bundle: nil), forCellReuseIdentifier: "buttonCell")
        tableView!.showsVerticalScrollIndicator = false
        tableView!.showsHorizontalScrollIndicator = false
        tableView!.tableFooterView = UIView.init()
        tableView!.bounces = false
        tableView!.contentInset = UIEdgeInsetsMake(2, 0, 0, 0)
        
        self.addSubview(self.tableView!)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(dissmiss))
        
        tap.delegate = self
        self.addGestureRecognizer(tap)

        tableView!.translatesAutoresizingMaskIntoConstraints = false
        let leftConstraint = NSLayoutConstraint(item: tableView!,
                                                attribute: .Right,
                                                relatedBy: .Equal,
                                                toItem: self,
                                                attribute: .Right,
                                                multiplier: 1,
                                                constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(item: tableView!,
                                                  attribute: .Bottom,
                                                  relatedBy: .Equal,
                                                  toItem: self,
                                                  attribute: .Bottom,
                                                  multiplier: 1,
                                                  constant: 0.0)
        let rigthConstraint = NSLayoutConstraint(item: tableView!,
                                                 attribute: .Left,
                                                 relatedBy: .Equal,
                                                 toItem: self,
                                                 attribute: .Left,
                                                 multiplier: 1,
                                                 constant: 0.0)
        let heightConstraint = NSLayoutConstraint(item: tableView!,
                                                  attribute: .Height,
                                                  relatedBy: .Equal,
                                                  toItem: nil,
                                                  attribute: .NotAnAttribute,
                                                  multiplier: 1,
                                                  constant: 204)
        
        self.addConstraints([rigthConstraint,leftConstraint,bottomConstraint,heightConstraint])
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        print("\(gestureRecognizer) \(otherGestureRecognizer)")
        if otherGestureRecognizer.isKindOfClass(UITapGestureRecognizer) {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            return HerdViewCell.HerdViewCells(tableView,indexPath: indexPath,identifier: "cell")
        }
        
        return ButtonCell.ButtonCells(tableView, indexPath: indexPath, identifier: "buttonCell",title: titleArray[indexPath.row - 1])
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 70
        }
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row != 0 {
            self.selectBlock?(selectIdx: indexPath.row - 1)
        }
    }
    
    func getSelectIndex(selectBlock : SelectBlock?) -> Void {
        self.selectBlock = selectBlock
    }
    
    class func show() {
        
        let window = UIApplication.sharedApplication().keyWindow
        let view = PopUpView.manager
        view.tableView!.transform = CGAffineTransformMakeTranslation(0, 204)
        view.alpha = 0
        window!.addSubview(view)
        UIView.animateWithDuration(0.2) {
            view.alpha = 1
            view.tableView!.transform = CGAffineTransformIdentity
        }
        
    }
    
    func dissmiss() {
        let view = PopUpView.manager
        UIView.animateWithDuration(0.2, animations: {
            view.alpha = 0
            view.tableView!.transform = CGAffineTransformMakeTranslation(0, 184)
        }) { (f) in
            view.removeFromSuperview()
        }
        
    }
    
    class func dismiss() {
        
        let view = PopUpView.manager
        view.dissmiss()
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
