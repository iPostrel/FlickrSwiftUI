//
//  UserSettings.swift
//  FlickrSwiftUI
//
//  Created by Денис on 04.06.2022.
//

import Foundation

class UserSettings: ObservableObject {
    @Published var username: String {
        didSet {
            UserDefaults.standard.set(username, forKey: "username")
        }
    }
    
    init() {
        self.username = UserDefaults.standard.object(forKey: "username") as? String ?? ""
    }
}
