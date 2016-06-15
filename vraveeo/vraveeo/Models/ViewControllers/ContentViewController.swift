//
//  ContentViewController.swift
//  vraveeo
//
//  Created by Agisilaos Tsaraboulidis on 08/06/16.
//  Copyright © 2016 Agisilaos Tsaraboulidis. All rights reserved.
//

import UIKit
import DigitsKit
import Fabric

class ContentViewController: UIViewController {
  
  
    @IBOutlet weak var InfoimageView: UIImageView!
    @IBOutlet weak var titleBoard: UILabel!
    @IBOutlet weak var descriptionBoard: UILabel!
    @IBOutlet weak var StartMessagingButton: UIButton!
    
    var pageIndex: Int!
    var titleText: String!
    var descText: String!
    var imageFile: String!
    var buttonText: String!
  
    override func viewDidLoad() {
      super.viewDidLoad()

      self.InfoimageView.image = UIImage( named: self.imageFile)
      self.titleBoard.text = self.titleText
      self.descriptionBoard.text = self.descText
      self.StartMessagingButton.setTitle (self.buttonText, forState: .Normal)
      
      
      
    }
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
      // Dispose of any resources that can be recreated.
    }
    
  @IBAction func DidTapppedStartMssgButton(sender: AnyObject) {
    let digits = Digits.sharedInstance()
    let configuration = DGTAuthenticationConfiguration(accountFields: .DefaultOptionMask)
    configuration.phoneNumber = "+30"
    configuration.appearance = DGTAppearance()

 
    configuration.appearance.accentColor = UIColor(red: 228/255, green: 64/255, blue: 71/255, alpha: 1.0) /* #e44047 */

     digits.authenticateWithViewController(self, configuration: configuration) { (session, error) -> Void in
      if (session != nil) {
        // TODO: associate the session userID with your user model
        
        self.performSegueWithIdentifier("Next", sender: nil)
      } else {
        NSLog("Authentication error: %@", error!.localizedDescription)
      }

      // Inspect session/error objects
      print("yeah")
    }
      }
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  }








