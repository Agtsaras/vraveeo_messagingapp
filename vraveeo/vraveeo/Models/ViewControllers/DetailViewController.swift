//
//  DetailViewController.swift
//  vraveeo
//
//  Created by Agisilaos Tsaraboulidis on 11/06/16.
//  Copyright © 2016 Agisilaos Tsaraboulidis. All rights reserved.
//

import UIKit
import Contacts

class DetailViewController: UIViewController {
  
  @IBOutlet weak var contactImage: UIImageView!
  
  @IBOutlet weak var fullName: UILabel!
  @IBOutlet weak var address: UILabel!
  @IBOutlet weak var email: UILabel!
  
  var contactItem: CNContact? {
    didSet {

      // Update the view.
      self.configureView()
    }
  }
  
  func configureView() {
    // Update the user interface for the detail item.
    if let contact = self.contactItem {
      let store = CNContactStore()
      
      do {
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName), CNContactEmailAddressesKey, CNContactPostalAddressesKey, CNContactImageDataKey, CNContactImageDataAvailableKey]
        let contact = try store.unifiedContactWithIdentifier(contact.identifier, keysToFetch: keysToFetch)
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          if contact.imageDataAvailable {
            if let data = contact.imageData {
              self.contactImage?.image = UIImage(data: data)
            }
          }
          
          self.fullName.text = CNContactFormatter().stringFromContact(contact)
          
          self.email.text = contact.emailAddresses.first?.value as? String
          
          if contact.isKeyAvailable(CNContactPostalAddressesKey) {
            if let postalAddress = contact.postalAddresses.first?.value as? CNPostalAddress {
              self.address.text = CNPostalAddressFormatter().stringFromPostalAddress(postalAddress)
            } else {
              self.address.text = "No Address"
            }
          }
        })
      } catch {
        print(error)
      }
    }
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
   navigationController!.navigationBar.tintColor = UIColor.whiteColor()
    UIApplication.sharedApplication().statusBarStyle = .LightContent
    contactImage.layer.borderWidth = 1
    contactImage.layer.masksToBounds = true
    contactImage.layer.borderColor = UIColor.blackColor().CGColor
    contactImage.layer.cornerRadius = contactImage.frame.height/2
    contactImage.clipsToBounds = true


    self.configureView()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
