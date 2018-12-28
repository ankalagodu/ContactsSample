//
//  SQLite3Manager.swift
//  CodingInterviewSample
//
//  Created by Koushik on 27/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import Foundation
import SQLite
import SwiftyJSON


class SQLLiteManager {
    static let instance = SQLLiteManager()
    
    private let db: Connection?
    
    private let contacts = Table("contacts")
    private let id = Expression<Int64>("id")
    private let firstName = Expression<String?>("firstName")
    private let lastName = Expression<String>("lastName")
    private let emailId = Expression<String>("emailId")
    private let imageUrl = Expression<String>("imageUrl")
    
    private init() {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        do {
            db = try Connection("\(path)/contacts.sqlite3")
        } catch {
            db = nil
            print ("Unable to open database")
        }
        
        createTable()
    }
    
    func createTable() {
        do {
            try db?.run(contacts.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(firstName)
                table.column(lastName)
                table.column(emailId, unique: true)
                table.column(imageUrl)
            })
        } catch {
            print("Unable to create table")
        }
    }
    
    func addContact(cfirstname: String, clastname: String, cemailId: String, cimageurl:String) -> Int64? {
        do {
            let insert = contacts.insert(firstName <- cfirstname, lastName <- clastname, emailId <- cemailId, imageUrl <- cimageurl)
            let id = try db!.run(insert)
            
            return id
        } catch {
            print("Insert failed")
            return nil
        }
    }
    
    func getContacts() -> [Contact] {
        var contacts = [Contact]()
        
        do {
            for contact in try db!.prepare(self.contacts) {
                contacts.append(Contact(
                    id: contact[id],
                    firstName: contact[firstName]!,
                    lastName: contact[lastName],
                    emailId: contact[emailId],
                    imageUrl: contact[imageUrl]))
            }
        } catch {
            print("Select failed")
        }
        
        return contacts
    }
    
    
    func updateContact(cid:Int64, newContact: Contact) -> Bool {
        let contact = contacts.filter(id == cid)
        do {
            let update = contact.update([
                firstName <- newContact.firstName,
                lastName <- newContact.lastName,
                emailId <- newContact.emailId,
                imageUrl <- newContact.imageUrl
                ])
            if try db!.run(update) > 0 {
                return true
            }
        } catch {
            print("Update failed: \(error)")
        }
        
        return false
    }
    
    func callAPIPostRequest(_ success:@escaping (Bool) -> Void){
        
        guard let emailId = UserDefaults.standard.getEmailID() else{
            return
        }
        APIWrapper.postRequestWithURL(emailId, success: { (response) in
            
            // get the items from the JSON response
            guard let itemsJsonArray = response["items"].arrayObject else {  return  }
        
            if itemsJsonArray.count > 0{
                
                for (index, item) in itemsJsonArray.enumerated(){
                    
                    let jsonItem = JSON(item)
                    let firstName = jsonItem["firstName"].stringValue
                    let lastName = jsonItem["lastName"].stringValue
                    let emailId = jsonItem["emailId"].stringValue
                    let imageUrl = jsonItem["imageUrl"].stringValue
                    
                    if let id = self.addContact(cfirstname: firstName, clastname: lastName, cemailId: emailId, cimageurl: imageUrl) {
                        print("Insert success:\(id)")
                    }else{
                        let id = Int64(index)
                        let contact = Contact(id: id, firstName:firstName, lastName: lastName, emailId: emailId, imageUrl: imageUrl)
                        if self.updateContact(cid: id, newContact: contact){
                            print("Update success:\(id)")
                        }else{
                            print("Update failed:\(id)")
                        }
                    }
                }
                success(true)
            }else{
                // no data
                
            }
            
        }, failure: { (error) in
            DispatchQueue.main.async {
                UIHelper.showMessage("Failed!", message: error.localizedDescription)
            }
        })
    }
    
}



