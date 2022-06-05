//
//  LogoView.swift
//  FlickrSwiftUI
//
//  Created by Денис on 05.06.2022.
//

import SwiftUI

struct LogoView: View {
    private let size = 70.0
    
    var body: some View {
        HStack {
            Rectangle()
                .frame(width: size, height: size)
                .foregroundColor(.blue)
                .cornerRadius(.infinity)
            Rectangle()
                .frame(width: size, height: size)
                .foregroundColor(.red)
                .cornerRadius(.infinity)
        }
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
