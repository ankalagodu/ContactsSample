//
//  String.swift
//  CodingInterviewSample
//
//  Created by Koushik on 28/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import Foundation

extension String {
    
    func isEmail() -> Bool{
        let regex = "[a-zA-Z0-9.\\-_]{2,32}@[a-zA-Z0-9.\\-_]{2,32}\\.[A-Za-z]{2,4}"
        let regExPredicate = NSPredicate.init(format: "SELF MATCHES %@", regex)
        return regExPredicate.evaluate(with:self)
    }

}
