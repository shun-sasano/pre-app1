//
//  PageMenuModel.swift
//  pre-app1
//
//  Created by 笹野　駿 on 2016/08/15.
//  Copyright © 2016年 shun-sasano. All rights reserved.
//

import Foundation
import PageMenu

class PageMenuModel {
    var pageMenu: CAPSPageMenu?
    let params: [CAPSPageMenuOption]
    var controllerArray: [UIViewController] = []
    
    init() {
        params = [
            .ScrollMenuBackgroundColor(UIColor.blackColor()),
            .ViewBackgroundColor(UIColor.blackColor()),
            .SelectionIndicatorColor(UIColor.orangeColor()),
            .BottomMenuHairlineColor(UIColor.blackColor()),
            .MenuItemFont(UIFont(name: "HelveticaNeue", size: 13.0)!),
            .MenuHeight(80.0),
            .MenuItemWidth(120.0),
            .CenterMenuItems(true),
            .MenuItemSeparatorWidth(4.3)   ]
    }
    func addController(viewController: UIViewController) {
        self.controllerArray.append(viewController)
    }
    
    func setPageMenu(baseViewController: UIViewController) {
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0.0, 50.0, baseViewController.view.frame.width, baseViewController.view.frame.height), pageMenuOptions: params)
        baseViewController.view.addSubview(pageMenu!.view)
        
    }
}

