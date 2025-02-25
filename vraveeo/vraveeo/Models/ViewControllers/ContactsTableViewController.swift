//
//  ContactsTableViewController.swift
//  vraveeo
//
//  Created by Agisilaos Tsaraboulidis on 10/06/16.
//  Copyright © 2016 Agisilaos Tsaraboulidis. All rights reserved.
//


import UIKit
import Contacts
import AddressBook
import DigitsKit



class ContactsTableViewController: UITableViewController {
  
  var detailViewController: DetailViewController? = nil
  var objects = [CNContact]()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    UIApplication.sharedApplication().statusBarStyle = .LightContent
    
    
        
    
 
    
    NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ContactsTableViewController.insertNewObject(_:)), name: "addNewContact", object: nil)
    self.getContacts()
  }
  
  func getContacts() {
    let store = CNContactStore()
    
    if CNContactStore.authorizationStatusForEntityType(.Contacts) == .NotDetermined {
      store.requestAccessForEntityType(.Contacts, completionHandler: { (authorized: Bool, error: NSError?) -> Void in
        if authorized {
          self.retrieveContactsWithStore(store)
        }
      })
    } else if CNContactStore.authorizationStatusForEntityType(.Contacts) == .Authorized {
      self.retrieveContactsWithStore(store)
    }
    
  }
  
  func retrieveContactsWithStore(store: CNContactStore) {
    let request = CNContactFetchRequest(keysToFetch: [CNContactEmailAddressesKey, CNContactFormatter.descriptorForRequiredKeysForStyle(.FullName)])
    
    var contacts = [CNContact]()
    do {
      try store.enumerateContactsWithFetchRequest(request) { contact, stop in
        contacts.append(contact)
      }
      
      
      
      self.objects = contacts
      NSOperationQueue.mainQueue().addOperationWithBlock({
        self.tableView.reloadData()
      })
    } catch {
      print(error)
    }
  }
  
  func addExistingContact() {
    
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func insertNewObject(sender: NSNotification) {
    if let contact = sender.userInfo?["contactToAdd"] as? CNContact {
      objects.insert(contact, atIndex: 0)
      let indexPath = NSIndexPath(forRow: 0, inSection: 0)
      self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
  }
  
  // MARK: - Segues
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "showDetail" {
      if let indexPath = self.tableView.indexPathForSelectedRow {
        let object = objects[indexPath.row]
        let controller =  segue.destinationViewController as! DetailViewController
          
        controller.contactItem = object
        controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
        controller.navigationItem.leftItemsSupplementBackButton = true
        
      }
    }
  }
  
  

  
  // MARK: - Table View
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
    
    let contact = self.objects[indexPath.row]
    let formatter = CNContactFormatter()
    
    cell.textLabel?.text = formatter.stringFromContact(contact)
    //cell.detailTextLabel?.text = contact.emailAddresses.first?.value as? String
    
    return cell
  }
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return false
  }
  
  
 
  
}
