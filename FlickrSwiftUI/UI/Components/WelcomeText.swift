//
//  WelcomeText.swift
//  FlickrSwiftUI
//
//  Created by Денис on 05.06.2022.
//

import SwiftUI

struct WelcomeText: View {
    private let textWelcome = "Welcome to Flickr!"
    
    var body: some View {
        Text(textWelcome)
            .font(.largeTitle)
            .fontWeight(.semibold)
    }
}

struct WelcomeText_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeText()
    }
}
