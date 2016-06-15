//
//  TabbarViewController.swift
//  vraveeo
//
//  Created by Agisilaos Tsaraboulidis on 12/06/16.
//  Copyright © 2016 Agisilaos Tsaraboulidis. All rights reserved.
//

import UIKit
import AVFoundation
class vraveeoTabBarController: UITabBarController {
  
  private var tapSoundEffect: AVAudioPlayer!
  private var session = AVAudioSession.sharedInstance()

  
  
  
  override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
    do {
      try session.setCategory(AVAudioSessionCategoryAmbient)
    } catch {
      print("Failed setting category")
    }
    
    let path = NSBundle.mainBundle().pathForResource("tabBarDidSelectItem.m4a", ofType: nil)!
    let url = NSURL(fileURLWithPath: path)
    
    do {
      let sound = try AVAudioPlayer(contentsOfURL: url)
      self.tapSoundEffect = sound
      self.tapSoundEffect.volume = 0.1
      sound.play()
    } catch {
      print("Failed to load tab bar sound file")
    }
  }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
