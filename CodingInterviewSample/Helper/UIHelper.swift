//
//  UIHelper.swift
//  CodingInterviewSample
//
//  Created by Koushik on 28/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit


class UIHelper{
    
    class func showMessage(_ title:String, message:String){
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        // show the alert
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
    
    // show oktasso/local login screen
    class func showContactDetail(){
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        guard let rootViewController = window.rootViewController else {
            return
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let contactsTableViewController: ContactTableViewController = storyboard.instantiateViewController(withIdentifier: "ContactTableViewController") as! ContactTableViewController
        let navigationController = UINavigationController(rootViewController: contactsTableViewController)
        contactsTableViewController.view.frame = rootViewController.view.frame
        contactsTableViewController.view.layoutIfNeeded()
        
        UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
            window.rootViewController = navigationController
        }, completion: { completed in
            // maybe do something here
        })
    }
}
