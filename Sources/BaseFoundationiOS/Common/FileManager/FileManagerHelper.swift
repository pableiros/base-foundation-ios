//
//  FileManagerHelper.swift
//  
//
//  Created by pablo borquez on 23/02/24.
//

import UIKit

open class FileManagerHelper {
    static let category = String(describing: FileManagerHelper.self)
    
    open var directoryName: String {
        fatalError("override required")
    }
    
    public init() { }
    
    open func saveImageTmp(filename: String, image: UIImage) -> URL? {
        guard let data = image.jpegData(compressionQuality: 1) else { return nil }
        
        let fileURL = self.createTmpFileURL(filename: filename)
        
        self.save(fileURL: fileURL, data: data)
        
        return fileURL
    }
    
    open func save(fileURL: URL, data: Data) {
        self.remove(fileURL: fileURL)
        
        do {
            try data.write(to: fileURL)
        } catch let error {
            print("error saving file with error", error)
        }
    }
    
    open func remove(fileURL: URL?) {
        guard let fileURL = fileURL, FileManager.default.fileExists(atPath: fileURL.path) else { return }
        
        do {
            try FileManager.default.removeItem(atPath: fileURL.path)
        } catch {
//            CoreLogger.shared.error("Couldn't remove file at path \(error.localizedDescription)",
//                                    className: String(describing: self),
//                                    method: #function,
//                                    line: #line)
        }
    }
    
    open func copyFileToTmp(filename: String, url: URL) -> URL? {
        var fileTmpUrl: URL?
        
        guard url.startAccessingSecurityScopedResource() else { return fileTmpUrl }
        
        do {
            let fileUrl = self.createTmpFileURL(filename: filename)
            
            try? FileManager.default.removeItem(at: fileUrl)
            try FileManager.default.copyItem(at: url, to: fileUrl)
            try (fileUrl as NSURL).setResourceValue(URLFileProtection.complete,
                                                    forKey: .fileProtectionKey)
            
            fileTmpUrl = fileUrl
        } catch {
            OSLogger.standard.error(subsystem: AppConfiguration.shared.subsystem,
                                    category: Self.category,
                                    message: error)
        }
        
        return fileTmpUrl
    }
    
    open func createTmpFileURL(filename: String) -> URL {
        let tmpDirectoryURL = FileManager.default.temporaryDirectory
        let fileURL = tmpDirectoryURL.appendingPathComponent(filename)
        
        return fileURL
    }
    
    open func getDocumentsDirectory() -> URL? {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        guard paths.count > 0 else { return nil }
        
        let documentsDirectory = paths[0]
        
        return URL(string: documentsDirectory)
    }
    
    @discardableResult
    open func createDirectory(at url: URL?, directoryName: String) -> URL? {
        guard let url = url else { return nil }
        
        let directoryUrl = url.appendingPathComponent(directoryName)
        self.createDirectory(at: directoryUrl)
        
        return directoryUrl
    }
    
    open func createDirectory(at url: URL) {
        guard FileManager.default.fileExists(atPath: url.path) == false else { return }
        
        try? FileManager.default.createDirectory(atPath: url.path,
                                                 withIntermediateDirectories: true,
                                                 attributes: nil)
    }
    
    open func getImage(from url: URL) -> UIImage? {
        var image: UIImage?
        let path = url.path
        
        if FileManager.default.fileExists(atPath: path) {
            image = UIImage(contentsOfFile: path)
        }
        
        return image
    }
}
