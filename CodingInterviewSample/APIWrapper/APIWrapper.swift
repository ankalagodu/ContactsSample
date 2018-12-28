//
//  APIWrapper.swift
//  CodingInterviewSample
//
//  Created by Koushik on 28/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class APIWrapper {
    
    // post request to API header
    class func postRequestWithURL(_ email : String, success:@escaping (JSON) -> Void, failure:@escaping (Error) -> Void){
        
        // post request url
        let urlString = "http://surya-interview.appspot.com/list"
        // parameter for request
        let params:[String:Any] = ["emailId":"\(email)"]
        
        // JSON Serialization
        let jsonData = try! JSONSerialization.data(withJSONObject: params)
        
        // convert to JSON string
        let json = String(data: jsonData, encoding: String.Encoding.utf8)
        
        // unwrap the optional
        guard let url = URL(string: urlString), let jsonString=json else{
            return
        }
        
        // create url request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonString.data(using: String.Encoding.utf8)
        
        // make post request
        Alamofire.request(request).responseJSON { (response) in
            // checking response from API is success
            if response.result.isSuccess {
                let resJson = JSON(response.result.value!)
                success(resJson)
            }
            // checking response from API is failure
            if response.result.isFailure {
                let error : Error = response.result.error!
                failure(error)
            }
        }
    }
    
}
