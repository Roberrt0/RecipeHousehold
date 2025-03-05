//
//  ProfilePictureView.swift
//  RecipeManager
//
//  Created by Luis Roberto Martinez on 08/09/24.
//

import SwiftUI

struct ProfilePictureView: View {
    
    var userPicture: Image = Image("testingImage")
    let strokeGradient = LinearGradient(colors: [.red, .pink], startPoint: .top, endPoint: .bottom)
    
    var body: some View {
        userPicture
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .background{
                Circle()
                    .stroke(strokeGradient, lineWidth: 10.0)
            }
    }
}

#Preview {
    ProfilePictureView()
}
