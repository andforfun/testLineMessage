//
//  ViewController.swift
//  testDb
//
//  Created by 李小明 on 2016/12/16.
//  Copyright © 2016年 李小明. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import UserNotifications

class ViewController: UIViewController,UIPickerViewDelegate {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationName2 = Notification.Name("NewApplicantNoti")
        NotificationCenter.default.addObserver(self, selector: #selector(TableViewController.NewApplicantNoti(noti:)), name:
            notificationName2, object: nil)
//        let notificationName2 = Notification.Name("NewApplicantNoti")
//        NotificationCenter.default.addObserver(self, selector: #selector(NewApplicantNoti(noti:)), name:
//            notificationName2, object: nil)
        //appDelegate.isfirst = false
        
        //readWnater()
        //let a = FIRDatabase.database().reference()
        //a.child("load").updateChildValues(["load":data!])
        //let array = [["name":"123"],["name":"456"]]
        //a.child("dataTest").setValue(array)
        //readWnater()
        // Do any additional setup after loading the view, typically from a nib.
    }
//    func NewApplicantNoti(noti:Notification) {
////        self.tabBarController?.tabBar.items?[1].badgeValue = (String)(appDelegate.newMessage)
////        if appDelegate.haveNotRead == 0{
////            self.tabBarController?.tabBar.items?[1].badgeValue = nil
////        }
//        //appDelegate.isfirst = false
//        
//    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    func NewApplicantNoti(noti:Notification) {
        
        if appDelegate.newMessage == 0{
            self.tabBarController?.tabBar.items?[1].badgeValue = nil
        }else{
            self.tabBarController?.tabBar.items?[1].badgeValue =
            (String)(appDelegate.newMessage)
        }
       
//
//        self.tableView.reloadData()
//                        appDelegate.isfirst = false
        
    }

    override func viewWillAppear(_ animated: Bool) {
        

    }
    @IBAction func button(_ sender: AnyObject) {
       
    }
    

}

