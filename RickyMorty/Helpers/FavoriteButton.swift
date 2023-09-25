//
//  FavoriteButton.swift
//  RickyMorty
//
//  Created by Admin on 24/09/23.
//

import SwiftUI

struct FavoriteButton: View {
    @Binding var isSet: Bool
    var body: some View {
        Button{
            isSet.toggle()
        }label:{
            Image(systemName: isSet ? "star.fill":"star")
                .resizable()
                .frame(width:30, height: 30)
                .foregroundColor(isSet ? .yellow:.gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(isSet: .constant(true))
    }
}
