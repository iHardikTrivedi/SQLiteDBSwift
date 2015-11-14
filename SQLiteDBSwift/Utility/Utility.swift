//
//  Utility.swift
//  SQLiteDBSwift
//
//  Created by Hardik Trivedi on 11/11/2015.
//  Copyright © 2015 TheiHartBit. All rights reserved.
//

import UIKit

class Utility: NSObject
{
    class func getFilePathForDB(strFileName: String) -> String
    {
        let urlForFilePath = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let urlFile = urlForFilePath.URLByAppendingPathComponent(strFileName)
        
        return urlFile.path!
    }
    
    class func copyFileFromProjectToDevice(strFileName: NSString)
    {
        let strDBPath: String = getFilePathForDB(strFileName as String)
        let fileManager = NSFileManager.defaultManager()
        
        if !fileManager.fileExistsAtPath(strDBPath) {
            
            let urlForBundle = NSBundle.mainBundle().resourceURL
            let strFromPath = urlForBundle!.URLByAppendingPathComponent(strFileName as String)
            
            var error : NSError?
            do {
                try fileManager.copyItemAtPath(strFromPath.path!, toPath: strDBPath)
            } catch let error1 as NSError {
                error = error1
            }
            
            if (error != nil) {
                print("Error Occured")
                print("\((error?.localizedDescription)!)")
            } else {
                print("Copy DB Successfully")
                print("Your SQLite DB copy successfully on Your Device.")
            }
        } else {
            print("DB is already on Your Device.")
        }
    }
}
