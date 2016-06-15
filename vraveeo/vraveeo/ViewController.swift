//
//  ViewController.swift
//  vraveeo
//
//  Created by Agisilaos Tsaraboulidis on 07/06/16.
//  Copyright © 2016 Agisilaos Tsaraboulidis. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPageViewControllerDataSource {
  
  var pageViewController: UIPageViewController!
  var pageTitles: NSArray!
  var pageDescriptions: NSArray!
  var pageImages: NSArray!
  var ButtonTitles: NSArray!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.pageTitles = NSArray(objects: "Welcome to vraveeo❤️", "Chat with your friends👥", "Discover new businesses🔎", "Discover new products🎉", "")
    self.pageDescriptions = NSArray(objects: "Swipe to learn more", "Share your points", "Earn points by sharing your experience", "Share them with your friends", "")
    self.pageImages = NSArray(objects: "Page1", "Page2", "Page3", "Page4", "Page5")
    self.ButtonTitles = NSArray(objects: "", "", "", "", "Start Messaging >")
    
    
    self.pageViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageViewController") as? UIPageViewController
    
    self.pageViewController?.dataSource = self
    
    let startVC = self.viewControllerAtIndex(0) as ContentViewController
    let viewControllers = NSArray(object: startVC)
    
    self.pageViewController.setViewControllers(viewControllers as? [UIViewController], direction: .Forward, animated: true, completion: nil)
    
    self.pageViewController.view.frame = CGRectMake(0, 50, self.view.frame.width, self.view.frame.size.height - 60)
    
    
    self.addChildViewController(self.pageViewController)
    self.view.addSubview(pageViewController.view)
    self.pageViewController.didMoveToParentViewController(self)
    
    
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  
  
  
  
  
  func viewControllerAtIndex(index: Int) -> ContentViewController {
    
    if ((self.pageTitles.count == 0) || (self.pageDescriptions.count == 0) || (index >= self.pageDescriptions.count) || (index >= self.pageTitles.count)) {
      
      return ContentViewController()
    }
    
    
    
    let vc: ContentViewController = (self.storyboard?.instantiateViewControllerWithIdentifier("ContentViewController") as? ContentViewController)!
    
    vc.imageFile = self.pageImages[index] as! String
    vc.titleText = self.pageTitles[index] as! String
    vc.descText = self.pageDescriptions[index] as! String
    vc.buttonText = self.ButtonTitles[index] as! String
    vc.pageIndex = index
    
    return vc
}

  // Mark: -Page View Controller Data Source
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
    
    
    let vc = viewController as! ContentViewController
    var index = vc.pageIndex as Int
    
    
    if ( index == 0 || index == NSNotFound) {
      
      return nil
      
      
    }
    
    
    index -= 1
    return self.viewControllerAtIndex(index)
    
    
  }
  
  
  func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
    
    let vc = viewController as! ContentViewController
    var index = vc.pageIndex as Int
    
    if (index == NSNotFound) {
      
      return nil
    }
    
    index += 1
    
    
    if (index == self.pageTitles.count) {
      
      return nil
    }
    
    
    return self.viewControllerAtIndex(index)
    
  }
  
  
  func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
    return self.pageTitles.count
  }
  
  
  
  
  func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
    return 0
  }
  
}


