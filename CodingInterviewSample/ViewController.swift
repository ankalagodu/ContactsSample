//
//  ViewController.swift
//  CodingInterviewSample
//
//  Created by Koushik on 27/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.title = "Entry Form"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func didSubmitButtonTapped(_ sender: Any) {
        
        if let email = emailTextField.text, email != ""{
            
            if email.isEmail(){
                UserDefaults.standard.saveEmailID(email)
                
                SQLLiteManager.instance.callAPIPostRequest({ (isCompleted) in
                    if isCompleted{
                        // present contact details screen
                        UIHelper.showContactDetail()
                    }
                })
            }else{
                UIHelper.showMessage("Failed!", message: "Please enter valid email address")
            }
            

        }else{
            UIHelper.showMessage("Failed!", message: "Please enter email address")
        }
    }
    
    
}
