//
//  TableViewController.swift
//  testDb
//
//  Created by 李小明 on 2017/1/11.
//  Copyright © 2017年 李小明. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var data:[String]!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationName2 = Notification.Name("NewApplicantNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.NewApplicantNoti(noti:)), name:
            notificationName2, object: nil)
      
            data = [appDelegate.data]
        
       
//        let notificationName = Notification.Name("ApplicantNoti")
//        NotificationCenter.default.addObserver(self, selector: #selector(ApplicantNoti(noti:)), name:
//            notificationName2, object: nil)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if data == nil{
            return 0
        }
        return data.count
    }
    func NewApplicantNoti(noti:Notification) {
        
        if data == nil{
            data = [appDelegate.data]
        }
        else{
            data.insert(appDelegate.data, at: 0)
        }
       
        if appDelegate.newMessage == 0{
                self.tabBarController?.tabBar.items?[1].badgeValue = nil
        }
        else{
             self.tabBarController?.tabBar.items?[1].badgeValue = (String)(appDelegate.newMessage)
            
        }
         self.tableView.reloadData()
        
        
    }
    func ApplicantNoti(noti:Notification) {
        
//        if data == nil{
//            data = [appDelegate.data]
//        }
//        else{
//            data.insert(appDelegate.data, at: 0)
//        }
//        
//        if appDelegate.newMessage == 0{
//            self.tabBarController?.tabBar.items?[1].badgeValue = nil
//        }
//        else{
//            self.tabBarController?.tabBar.items?[1].badgeValue = (String)(appDelegate.newMessage)
//            
//        }
//        self.tableView.reloadData()
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let nameLab = cell.contentView.viewWithTag(1) as! UILabel
        nameLab.text = data[indexPath.row]
        // Configure the cell...

        return cell
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
