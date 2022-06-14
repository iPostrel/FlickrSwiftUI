//
//  KeychainPropertyWrapper.swift
//  FlickrSwiftUI
//
//  Created by Денис on 10.06.2022.
//

import SwiftUI

@propertyWrapper
struct KeychainPropertyWrapper: DynamicProperty {
    @State var data: Data?
        
        var wrappedValue: Data? {
            get { data }
            set {
                guard let newData = newValue else {
                    // if setting data to `nil`
                    // delete it from the Key Chain
                    data = nil
                    let vol = KeychainHelper.shared.delete(key: key, account: account)
                    print(vol)
                    return
                }
                KeychainHelper.shared.save(data: newData, key: key, account: account)
                data = newData
            }
        }
        
        var key: String
        var account: String
        
        init(key: String, account: String) {
            self.key = key
            self.account = account
            
            _data = State(wrappedValue: KeychainHelper.shared.read(key: key, account: account))
        }
}
