//
//  AuthorizationContainer.swift
//  FlickrSwiftUI
//
//  Created by Денис on 08.06.2022.
//

import CoreData

class PhotoContainer {
    let persistentContainer: NSPersistentContainer
    
    init() {
        persistentContainer = NSPersistentContainer(name: "PhotoDataModel")
        persistentContainer.loadPersistentStores { _, _ in }
    }
}
