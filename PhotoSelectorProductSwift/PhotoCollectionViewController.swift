//
//  PhotoCollectionViewController.swift
//  PhotoSelectorProductSwift
//
//  Created by 云族佳 on 16/4/22.
//  Copyright © 2016年 温仲斌. All rights reserved.
//

import UIKit

import AssetsLibrary

private let reuseIdentifier = "photoCell"

class PhotoCollectionViewController: UICollectionViewController , UICollectionViewDelegateFlowLayout {
    
    var group : ALAssetsGroup?
    var itemArray = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        self.collectionView!.backgroundColor = UIColor.whiteColor()
        // Register cell classes
        self.collectionView!.registerNib(UINib.init(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        if self.group != nil {
            self.title = (self.group!.valueForProperty(ALAssetsGroupPropertyName) as! String)
            PhotoAlbumMamager.sharedInstance.getAssetArrayWithGroup(self.group) { (array) in
                self.itemArray = array
                self.collectionView?.reloadData()
            }
        }else {
            self.title = "相机胶卷"
            PhotoAlbumMamager.sharedInstance.getCameraFilm({ (array) in
                self.itemArray = array
                self.collectionView?.reloadData()
            })
        }
        
   self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.dissmiss))

        // Do any additional setup after loading the view.
    }
    
    func dissmiss() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items

        return (itemArray.count)
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = (collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoCell)
    
        let asset = itemArray[indexPath.row] as! ALAsset
        cell.photoImage.image = UIImage.init(CGImage: asset.aspectRatioThumbnail().takeUnretainedValue())
        
        return cell
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake((CGRectGetWidth((self.collectionView?.bounds)!) - 3) / 4, (CGRectGetWidth((self.collectionView?.bounds)!) - 3) / 4)
    }

//     MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
