//
//  PhotoAlbumMamager.swift
//  PhotoSelectorProductSwift
//
//  Created by 云族佳 on 16/4/22.
//  Copyright © 2016年 温仲斌. All rights reserved.
//

import UIKit
import AssetsLibrary

public typealias ReloadGroupArrayBlock = (array : [ALAssetsGroup])->Void
public typealias ReloadCameraFilmArrayBlock = (array : [AnyObject])->Void
public typealias ReloadGroupArrayErrorBlock = (error : NSError)->Void

class PhotoAlbumMamager: NSObject {
    static let sharedInstance = PhotoAlbumMamager()
    let assetsLibrary = ALAssetsLibrary.init()
    
    var groupArray = [ALAssetsGroup]()
    
//    var reloadGroupArrayBlock : ReloadGroupArrayBlock?
    
    override init() {
        super.init()
        
     }
    
    func getAlbumGroups(reloadGroupArrayBlock : ReloadGroupArrayBlock?, reloadGroupArrayErrorBlock : ReloadGroupArrayErrorBlock?) -> Void {
        self.assetsLibrary.enumerateGroupsWithTypes(ALAssetsGroupAll, usingBlock: { (group, stop) in
            if (group != nil && group.numberOfAssets() != 0)  {
                
                self.groupArray.append(group)
            }else {
                
                reloadGroupArrayBlock?(array: self.groupArray)
            }
            }, failureBlock: { (error) in
                reloadGroupArrayErrorBlock?(error: error!)
        })
    }
    
    func getCameraFilm(reloadCameraFilmArrayBlock:ReloadCameraFilmArrayBlock?) {
            getAlbumGroups({ (array) in
                for group in (array as [ALAssetsGroup]){
                    if group.valueForProperty(ALAssetsGroupPropertyName).isEqualToString("相机胶卷") {
                        
                        var cameraFilmArray = [ALAsset]()
                        
                        group.enumerateAssetsUsingBlock({ (asset, idx, stop) in
                            if asset != nil {
                                cameraFilmArray.append(asset)
                            }else {
                                reloadCameraFilmArrayBlock?(array: cameraFilmArray)
                            }
                        })
                        break
                    }
                }
                }, reloadGroupArrayErrorBlock: nil)
    }
    
    func getAssetArrayWithGroup(group : ALAssetsGroup?, reloadCameraFilmArrayBlock:ReloadCameraFilmArrayBlock?) {
        var cameraFilmArray = [ALAsset]()
        group?.enumerateAssetsUsingBlock({ (asset, idx, stop) in
            if asset != nil {
                cameraFilmArray.append(asset)
            }else {
                reloadCameraFilmArrayBlock?(array: cameraFilmArray)
            }
        })
    }
}
