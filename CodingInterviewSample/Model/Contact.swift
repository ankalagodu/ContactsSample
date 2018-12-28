//
//  Contact.swift
//  CodingInterviewSample
//
//  Created by Koushik on 28/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import Foundation

class Contact {
    let id: Int64?
    var firstName: String
    var lastName: String
    var emailId: String
    var imageUrl: String
    
    init(id: Int64) {
        self.id = id
        firstName = ""
        lastName = ""
        emailId = ""
        imageUrl = ""
    }
    
    init(id: Int64, firstName: String, lastName: String, emailId: String, imageUrl:String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.emailId = emailId
        self.imageUrl = imageUrl
    }
}
