//
//  TmpFileManager.swift
//
//
//  Created by pablo borquez on 23/02/24.
//

import Foundation

open class TmpFileManager: FileManagerHelper {
    override public init() { }
    
    override open func createTmpFileURL(filename: String) -> URL {
        let folderURL = self.createTmpDirectoryURL()
        var isDirectory: ObjCBool = false
    
        if FileManager.default.fileExists(atPath: folderURL.path, isDirectory: &isDirectory) == false {
            let tmpDirectoryURL = FileManager.default.temporaryDirectory
            self.createDirectory(at: tmpDirectoryURL, directoryName: self.directoryName)
        }
        
        return folderURL.appendingPathComponent(filename)
    }
        
    open func createTmpDirectoryURL() -> URL {
        let tmpDirectoryURL = FileManager.default.temporaryDirectory
        let folderURL = tmpDirectoryURL.appendingPathComponent(self.directoryName, isDirectory: true)
        
        return folderURL
    }
    
    open func createFileURL(filename: String) -> URL {
        self.createTmpDirectoryURL().appendingPathComponent(filename)
    }
    
    open func removeFolder() {
        let folderURL = self.createTmpDirectoryURL()
        try? FileManager.default.removeItem(atPath: folderURL.path)
    }
}
