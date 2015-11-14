//
//  RegisterAddEditViewController.swift
//  SQLiteDBSwift
//
//  Created by Hardik Trivedi on 11/11/2015.
//  Copyright © 2015 TheiHartBit. All rights reserved.
//

import UIKit

class RegisterAddEditViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtContact: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    
    var openViewMode: String!
    var registerID: NSInteger!
    
//    MARK: ViewLifeCycle Methods
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        lblTitle.text = "\(openViewMode) Register"
        
        if registerID == -1 {
            btnSave.setTitle("Save", forState: UIControlState.Normal)
        } else {
            btnSave.setTitle("Update", forState: UIControlState.Normal)
            loadDataFromRegisterID()
        }
    }
    
//    MARK: UITextFieldDelegate Methods
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        textField.resignFirstResponder()
        
        return true
    }
    
//    MARK: IBAction Methods
    
    @IBAction func btnBackClicked(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnSaveClicked(sender: AnyObject)
    {
        if txtName.text == "" || txtContact.text == "" || txtEmail.text == "" {
            let alertMessage: UIAlertView = UIAlertView(title: "Fill all Data", message: "Please fill all three (Name, Email, Contact) data.", delegate: nil, cancelButtonTitle: "Ok")
            alertMessage.show()
           
            return
        } else {
            let objRegisterModel: RegisterModel = RegisterModel()
            
            objRegisterModel.RegisterID = registerID
            objRegisterModel.Name = txtName.text!
            objRegisterModel.ContactNo = txtContact.text!
            objRegisterModel.Email = txtEmail.text!
            
            if registerID == -1 {
                if RegisterModelManager.getDBInstance().addRegisterData(objRegisterModel) {
                    let alertMessage: UIAlertView = UIAlertView(title: "Add Successfully.", message: "Your Data saved Successfully.", delegate: nil, cancelButtonTitle: "Ok")
                    alertMessage.show()
                }
            } else {
                if RegisterModelManager.getDBInstance().updateRegisterData(objRegisterModel) {
                    let alertMessage: UIAlertView = UIAlertView(title: "Update Successfully.", message: "Your Data updated Successfully.", delegate: nil, cancelButtonTitle: "Ok")
                    alertMessage.show()
                }
            }
            
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
//    MARK: Other Methods
    
    func loadDataFromRegisterID()
    {
        let objRegisterModel: RegisterModel = RegisterModelManager.getDBInstance().getRegisterDataByRegisterID(registerID)
        
        if objRegisterModel != "" {
            registerID = objRegisterModel.RegisterID
            txtName.text = "\(objRegisterModel.Name)"
            txtContact.text = "\(objRegisterModel.ContactNo)"
            txtEmail.text = "\(objRegisterModel.Email)"
        }
    }
}
