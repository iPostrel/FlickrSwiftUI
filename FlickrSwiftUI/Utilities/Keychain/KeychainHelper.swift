//
//  KeychainHelper.swift
//  FlickrSwiftUI
//
//  Created by Денис on 10.06.2022.
//

import Foundation

class KeychainHelper {
    static let shared = KeychainHelper()
    
    func save(data: Data, key: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        switch status {
        case errSecSuccess: print("success")
        case errSecDuplicateItem:
            let query = [
                kSecValueData: data,
                kSecAttrAccount: account,
                kSecAttrService: key,
                kSecClass: kSecClassGenericPassword
            ] as CFDictionary
            
            let updateAttr = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, updateAttr)
            
        default: print("Error \(status)")
        }
        printResultCode(resultCode: status)
    }
    
    func read(key: String, account: String) -> Data? {
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var resultData: AnyObject?
        let status = SecItemCopyMatching(query, &resultData)
        printResultCode(resultCode: status)
        return resultData as? Data
    }
    
    func delete(key: String, account: String) -> Bool {
        let query = [
            kSecAttrAccount: account,
            kSecAttrService: key,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        let status = SecItemDelete(query)
        printResultCode(resultCode: status)
        return status == errSecSuccess
    }
    
    private func printResultCode(resultCode: OSStatus) {
                // See: https://www.osstatus.com/
            switch resultCode {
                case errSecSuccess:
                    print("Keychain Status: No error.")
                case errSecUnimplemented:
                    print("Keychain Status: Function or operation not implemented.")
                case errSecIO:
                    print("Keychain Status: I/O error (bummers)")
                case errSecOpWr:
                    print("Keychain Status: File already open with with write permission")
                case errSecParam:
                    print("Keychain Status: One or more parameters passed to a function where not valid.")
                case errSecAllocate:
                    print("Keychain Status: Failed to allocate memory.")
                case errSecUserCanceled:
                    print("Keychain Status: User canceled the operation.")
                case errSecBadReq:
                    print("Keychain Status: Bad parameter or invalid state for operation.")
                case errSecInternalComponent:
                    print("Keychain Status: Internal Component")
                case errSecNotAvailable:
                    print("Keychain Status: No keychain is available. You may need to restart your computer.")
                case errSecDuplicateItem:
                    print("Keychain Status: The specified item already exists in the keychain.")
                case errSecItemNotFound:
                    print("Keychain Status: The specified item could not be found in the keychain.")
                case errSecInteractionNotAllowed:
                    print("Keychain Status: User interaction is not allowed.")
                case errSecDecode:
                    print("Keychain Status: Unable to decode the provided data.")
                case errSecAuthFailed:
                    print("Keychain Status: The user name or passphrase you entered is not correct.")
                default:
                    print("Keychain Status: Unknown. (\(resultCode))")
            }
        }
}
