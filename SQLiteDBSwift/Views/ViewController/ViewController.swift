//
//  ViewController.swift
//  SQLiteDBSwift
//
//  Created by Hardik Trivedi on 11/11/2015.
//  Copyright © 2015 TheiHartBit. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{
    
    @IBOutlet weak var tblRegister: UITableView!
    
    var marrRegisterData: NSMutableArray!
    
//    MARK: ViewLifeCycle Methods

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        marrRegisterData = NSMutableArray()
        fetchRegisterDataFromDB()
    }

//    MARK: UITableViewDelegate & DataSource Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return marrRegisterData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell: RegisterTableViewCell = tableView.dequeueReusableCellWithIdentifier("RegisterCell") as! RegisterTableViewCell
        
        let objRegisterModel: RegisterModel = marrRegisterData.objectAtIndex(indexPath.row) as! RegisterModel
        
        cell.lblName.text = objRegisterModel.Name
        cell.lblContact.text = "Contact : \(objRegisterModel.ContactNo)"
        cell.lblEmail.text = "Email : \(objRegisterModel.Email)"
        cell.accessibilityHint = "\(objRegisterModel.RegisterID)"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let objRegisterModel: RegisterModel = marrRegisterData.objectAtIndex(indexPath.row) as! RegisterModel
        openAddEditViewScreen(screenType: "Edit", recordID: objRegisterModel.RegisterID)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            let objRegisterModel: RegisterModel = marrRegisterData.objectAtIndex(indexPath.row) as! RegisterModel
            
            if RegisterModelManager.getDBInstance().deleteRegisterData(objRegisterModel) {
                let alertMessage: UIAlertView = UIAlertView(title: "Delete Successfully.", message: "Your Data deleted Successfully.", delegate: nil, cancelButtonTitle: "Ok")
                alertMessage.show()
                
                marrRegisterData = NSMutableArray()
                fetchRegisterDataFromDB()
            }
        }
    }
    
//    MARK: IBAction Methods
    
    @IBAction func btnAddClicked(sender: AnyObject)
    {
        openAddEditViewScreen(screenType: "Add", recordID: -1)
    }
    
//    MARK: Other Methods
    
    func fetchRegisterDataFromDB()
    {
        marrRegisterData = RegisterModelManager.getDBInstance().getRegisterData()
        
        tblRegister.reloadData()
    }
    
    func openAddEditViewScreen(screenType type:String, recordID id:NSInteger)
    {
        let objRegisterAddEditViewController: RegisterAddEditViewController = storyboard?.instantiateViewControllerWithIdentifier("RegisterAddEditViewController") as! RegisterAddEditViewController
        objRegisterAddEditViewController.openViewMode = type
        objRegisterAddEditViewController.registerID = id
        presentViewController(objRegisterAddEditViewController, animated: true, completion: nil)
    }
    
}

