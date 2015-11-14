//
//  RegisterModelManager.swift
//  SQLiteDBSwift
//
//  Created by Hardik Trivedi on 11/11/2015.
//  Copyright © 2015 TheiHartBit. All rights reserved.
//

import UIKit

let sharedInstance = RegisterModelManager()

class RegisterModelManager: NSObject
{
    var objFMDatabase: FMDatabase? = nil
    
    class func getDBInstance() -> RegisterModelManager
    {
        if(sharedInstance.objFMDatabase == nil) {
            sharedInstance.objFMDatabase = FMDatabase(path: Utility.getFilePathForDB("iHartDB.sqlite"))
        }
        
        return sharedInstance
    }
    
    func addRegisterData(objRegisterModel: RegisterModel) -> Bool
    {
        sharedInstance.objFMDatabase!.open()
        
        let isDataInserted = sharedInstance.objFMDatabase!.executeUpdate("INSERT INTO tblRegister (Name, ContactNo, Email) VALUES (?, ?, ?)", withArgumentsInArray: [objRegisterModel.Name, objRegisterModel.ContactNo, objRegisterModel.Email])
        
        sharedInstance.objFMDatabase!.close()
        
        return isDataInserted
    }
    
    func updateRegisterData(objRegisterModel: RegisterModel) -> Bool
    {
        sharedInstance.objFMDatabase!.open()
        
        let isDataUpdated = sharedInstance.objFMDatabase!.executeUpdate("UPDATE tblRegister SET Name = ?, ContactNo = ?, Email = ? WHERE RegisterID = ?", withArgumentsInArray: [objRegisterModel.Name, objRegisterModel.ContactNo, objRegisterModel.Email, objRegisterModel.RegisterID])
        
        sharedInstance.objFMDatabase!.close()
        
        return isDataUpdated
    }
    
    func deleteRegisterData(objRegisterModel: RegisterModel) -> Bool
    {
        sharedInstance.objFMDatabase!.open()
        
        let isDataDeleted = sharedInstance.objFMDatabase!.executeUpdate("DELETE FROM tblRegister WHERE RegisterID = ?", withArgumentsInArray: [objRegisterModel.RegisterID])
        
        sharedInstance.objFMDatabase!.close()
        
        return isDataDeleted
    }
    
    func getRegisterDataByRegisterID(registerID: NSInteger) -> RegisterModel
    {
        sharedInstance.objFMDatabase!.open()
        
        let resultSet: FMResultSet! = sharedInstance.objFMDatabase!.executeQuery("SELECT * FROM tblRegister WHERE RegisterID = ?", withArgumentsInArray: [registerID])
        
        let objRegisterModel : RegisterModel = RegisterModel()
        
        if (resultSet != nil) {
            while resultSet.next() {
                
                objRegisterModel.RegisterID = NSInteger(resultSet.stringForColumn("RegisterID"))!
                objRegisterModel.Name = resultSet.stringForColumn("Name")
                objRegisterModel.ContactNo = resultSet.stringForColumn("ContactNo")
                objRegisterModel.Email = resultSet.stringForColumn("Email")
            }
        }
        
        sharedInstance.objFMDatabase!.close()
        
        return objRegisterModel
    }
    
    func getRegisterData() -> NSMutableArray
    {
        sharedInstance.objFMDatabase!.open()
        
        let resultSet: FMResultSet! = sharedInstance.objFMDatabase!.executeQuery("SELECT * FROM tblRegister", withArgumentsInArray: nil)
        let marrRegister : NSMutableArray = NSMutableArray()
        
        if (resultSet != nil) {
            while resultSet.next() {
                let objRegisterModel : RegisterModel = RegisterModel()
                
                objRegisterModel.RegisterID = NSInteger(resultSet.stringForColumn("RegisterID"))!
                objRegisterModel.Name = resultSet.stringForColumn("Name")
                objRegisterModel.ContactNo = resultSet.stringForColumn("ContactNo")
                objRegisterModel.Email = resultSet.stringForColumn("Email")
                
                marrRegister.addObject(objRegisterModel)
            }
        }
        
        sharedInstance.objFMDatabase!.close()
        
        return marrRegister
    }
}
