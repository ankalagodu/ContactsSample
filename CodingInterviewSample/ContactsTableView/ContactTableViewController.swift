//
//  ContactTableViewController.swift
//  CodingInterviewSample
//
//  Created by Koushik on 28/12/18.
//  Copyright © 2018 Wolken Software Pvt Ltd. All rights reserved.
//

import UIKit
import Kingfisher

class ContactTableViewController: UITableViewController {

    private var contacts = [Contact]()
    private var selectedContact: Int?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadTableViewData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationItem.title = "Contact Details"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
        
        // Configure the cell...
        // create full name from contacts model
        let fullName = "\(contacts[indexPath.row].firstName) \(contacts[indexPath.row].lastName)"
        // set full name
        cell.fullNameLabel.text = fullName
        // get emailId from contacts model and set to cell
        cell.emailIdLabel.text = contacts[indexPath.row].emailId
        // get the image url from contacts model
        let imageUrl = contacts[indexPath.row].imageUrl
        // load imageview using imageUrl
        if let url = URL(string:imageUrl){
            let image = UIImage(named: "userIcon")
            cell.personImageView.kf.setImage(with:url, placeholder:image)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    fileprivate func loadTableViewData(){
        
        // get the contacts from local database
        contacts = SQLLiteManager.instance.getContacts()
        // reload tableview
        self.tableView.reloadData()
        // call API post request in background thread
        DispatchQueue.global(qos: .background).async {
            // call API Post Request
            SQLLiteManager.instance.callAPIPostRequest({ (isCompleted) in
                if isCompleted{
                    // reload tabelview in main thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            })
        }

    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
