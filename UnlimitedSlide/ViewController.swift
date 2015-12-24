//
//  ViewController.swift
//  UnlimitedSlide
//
//  Created by Other on 15/12/23.
//  Copyright © 2015年 wangyue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let names = ["0", "1", "2", "3", "1", "2", "3", "2"]
        let testView = UnlimitedSlideView(frame: CGRect(x: 30, y: 0, width: 100, height: 100))
        testView.contentViews(names)
        testView.clickPage = {
            (page: Int) in
            debugPrint("\(names[page])")
        }
        view.addSubview(testView)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

