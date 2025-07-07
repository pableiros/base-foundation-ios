//
//  BundleExtension.swift
//  BaseFoundationiOS
//
//  Created by pablo borquez on 07/07/25.
//

import Foundation

extension Bundle {
    public var appName: String {
        self.getInfo("CFBundleName")
    }
    
    public var displayName: String {
        self.getInfo("CFBundleDisplayName")
    }
    
    public var language: String {
        self.getInfo("CFBundleDevelopmentRegion")
    }
    
    public var identifier: String {
        self.getInfo("CFBundleIdentifier")
    }
    
    public var copyright: String {
        self.getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\\\n", with: "\n")
    }
    
    public var appBuild: String {
        self.getInfo("CFBundleVersion")
    }
    
    public var appVersionLong: String {
        self.getInfo("CFBundleShortVersionString")
    }
    
    private func getInfo(_ str: String) -> String {
        self.infoDictionary?[str] as? String ?? "⚠️"
    }
}
