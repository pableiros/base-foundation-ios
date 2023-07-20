//
//  Keychain.swift
//
//
//  Created by pablo borquez on 12/07/23.
//

import KeychainAccess

final public class Keychain {
    public static let shared = Keychain()
    
    private lazy var keychain = KeychainAccess.Keychain()
    
    public func setServiceNamespace(namespace: String) {
        self.keychain = KeychainAccess.Keychain(service: namespace)
    }
    
    public func set(value: String?, forKey key: String) {
        self.keychain[key] = value
    }
    
    public func get(key: String) -> String? {
        return self.keychain[key]
    }
    
    public func remove(key: String) {
        try? self.keychain.remove(key)
    }
    
    // MARK: - gets
    
    public func getToken() -> String? {
        return self.get(key: KeyChainKey.token)
    }
    
    public func getPassword(userId: String) -> String? {
        let key = KeyChainKey.generatePasswordKey(userId: userId)
        return self.get(key: key)
    }
    
    // MARK: - set
    
    public func set(token: String?) {
        self.set(value: token, forKey: "token")
    }
    
    public func set(password: String?, userId: String) {
        let key = KeyChainKey.generatePasswordKey(userId: userId)
        self.set(value: password, forKey: key)
    }
    
    // MARK: - removes
    
    public func removeToken() {
        self.remove(key: KeyChainKey.token)
    }
    
    public func removePassword(userId: String) {
        let key = KeyChainKey.generatePasswordKey(userId: userId)
        self.remove(key: key)
    }
}
