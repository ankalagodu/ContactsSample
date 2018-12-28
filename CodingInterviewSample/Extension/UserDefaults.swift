//
//  UserDefaults.swift
//  CodingInterviewSample
//
//  Created by Koushik on 28/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import Foundation

extension UserDefaults{
    
    // check for is first launch - only true on first invocation after app install, false on all further invocations
    // Note: Store this value in AppDelegate if you have multiple places where you are checking for this flag
    static func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    
    func saveEmailID(_ emailId:String){
        UserDefaults.standard.set(emailId, forKey: "emailId")
        UserDefaults.standard.synchronize()
    }
    
    func getEmailID() -> String?{
        return string(forKey: "emailId")
    }
    
    func clearUserDefaults(){
        removeObject(forKey: "emailId")
        removeObject(forKey: "hasBeenLaunchedBeforeFlag")
    }
}
