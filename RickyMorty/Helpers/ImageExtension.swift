//
//  ImageExtension.swift
//  RickyMorty
//
//  Created by Admin on 24/09/23.
//

import Foundation
import SwiftUI

extension Image {
    
    func imageModifier() -> some View {
        self
            .resizable()
            .scaledToFit()
    }
    
}
