//
//  UnlimitedSlideView.swift
//  UnlimitedSlide
//
//  Created by Other on 15/12/23.
//  Copyright © 2015年 wangyue. All rights reserved.
//

import UIKit

class UnlimitedSlideView: UIView {

    
    private var leftImageView , middleImageView , rightImageView : UIImageView?
    private var dataSourt: [String]?
    private var currentPage: Int?
    private var pageControl: UIPageControl?
    private var timer: NSTimer?
    private var scrollerView: UIScrollView?
    var clickPage: ((Int) -> Void)?
    
    func contentViews(names: [String]) {
        currentPage = 0
        dataSourt = names
        setupScrollerView()
        setupPageContrller()
        pageOf(leftPage: (dataSourt?.count)! - 1, middlePage: currentPage!, rightPage: currentPage! + 1)
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "next", userInfo: nil, repeats: true)
    }
    
    
   private func setupScrollerView() {
        let scrollerView = UIScrollView()
        scrollerView.frame = bounds
        scrollerView.contentSize = CGSize(width: width * CGFloat(3), height: height)
        scrollerView.bounces = false
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.showsVerticalScrollIndicator = false
        scrollerView.pagingEnabled = true
        scrollerView.contentOffset = CGPoint(x: width, y: 0)
        scrollerView.delegate = self
        leftImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: scrollerView.width, height: scrollerView.height))
        middleImageView = UIImageView(frame: CGRect(x: scrollerView.width, y: 0, width: scrollerView.width, height: scrollerView.height))
        rightImageView = UIImageView(frame: CGRect(x: scrollerView.width * 2, y: 0, width: scrollerView.width, height: scrollerView.height))
        
        leftImageView?.userInteractionEnabled = true
        middleImageView?.userInteractionEnabled = true
        rightImageView?.userInteractionEnabled = true
        
        
        scrollerView.addSubview(leftImageView!)
        scrollerView.addSubview(middleImageView!)
        scrollerView.addSubview(rightImageView!)
    
        let tap = UITapGestureRecognizer(target: self, action: "click")
        addGestureRecognizer(tap)
        self.scrollerView = scrollerView
        addSubview(scrollerView)
    }
    
    private func setupPageContrller() {
        let pageControl = UIPageControl()
        pageControl.height = 30
        pageControl.width = width
        pageControl.x = 0
        pageControl.y = height - 30
        pageControl.numberOfPages = (dataSourt?.count)!
        addSubview(pageControl)
        pageControl.currentPageIndicatorTintColor = UIColor.whiteColor()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        
        self.pageControl = pageControl
    }
    

    


    
}

extension UnlimitedSlideView: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.x
        
        if self.dataSourt?.count != 0 {
            
            if offset >= scrollView.width * 2 { // 右划
                scrollView.contentOffset = CGPointMake(scrollView.width, 0)
                currentPage!++
                
                if currentPage == (dataSourt?.count)! - 1 { // 当前是最后一页
                    self.pageOf(leftPage: currentPage! - 1, middlePage: currentPage!, rightPage: 0)
                } else if currentPage == (dataSourt?.count)! { // 当前是第一页
                    currentPage = 0
                    self.pageOf(leftPage: (dataSourt?.count)! - 1, middlePage: 0, rightPage: 1)
                } else { // 在中间位置
                    self.pageOf(leftPage: currentPage! - 1, middlePage: currentPage!, rightPage: currentPage! + 1)
                }
            }
         
            if offset <= 0 {
                scrollView.contentOffset = CGPoint(x: scrollView.width, y: 0)
                currentPage! -= 1
                
                if currentPage == 0 { // 第一页
                    self.pageOf(leftPage: (dataSourt?.count)! - 1, middlePage: 0, rightPage: 1)
                } else if currentPage == -1 {
                    currentPage = (dataSourt?.count)! - 1
                    self.pageOf(leftPage: currentPage! - 1, middlePage: currentPage!, rightPage: 0)
                } else {
                    self.pageOf(leftPage: currentPage! - 1, middlePage: currentPage!, rightPage: currentPage! + 1)
                    
                }
            }
             pageControl?.currentPage = currentPage!
        }
    }
    
    private func pageOf(leftPage leftPage: Int, middlePage: Int, rightPage: Int) {
        leftImageView?.image = UIImage(named: dataSourt![leftPage])
        middleImageView?.image = UIImage(named: dataSourt![middlePage])
        rightImageView?.image = UIImage(named: dataSourt![rightPage])
    }
    
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        timer!.invalidate()
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "next", userInfo: nil, repeats: true)
    }
}




extension UnlimitedSlideView {
    func click() {
        clickPage!(currentPage!)
    }
    
    func next() {
        scrollerView!.setContentOffset( CGPointMake(2 * width, 0), animated: true)
    }
}



