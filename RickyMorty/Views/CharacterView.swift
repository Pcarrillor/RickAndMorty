//
//  CharacterView.swift
//  RickyMorty
//
//  Created by Admin on 22/09/23.
//

import SwiftUI

struct CharacterView: View {
    let character: Result
    
    var body: some View {
        HStack(alignment:.top) {
            ImageLoadingView(url: character.image, key: "\(character.id)")
            VStack(alignment: .leading) {
                HStack {
                    Spacer(minLength: 0)
                    Text(character.name)
                        .font(.rickyMortyFont)
                        .foregroundColor(.green)
                    Spacer(minLength: 0)
                }
                HStack{
                    Image(character.status)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(4)
                        .background(Circle().fill(Color.yellow))
                    Text(character.status)
                        .foregroundColor(.white)
                }
                
                Text(character.species)
                    .font(.title3)
                    .foregroundColor(.white)
                
                Text("Last known location:")
                    .font(.callout)
                    .foregroundColor(.black.opacity(0.6))
                    .multilineTextAlignment(.leading)
                Text(character.location.name)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                
            }.padding(.horizontal)
            Spacer(minLength: 0)
        }
        .padding()
        .background{
            Color(.white)
                .opacity(0.5)
                .cornerRadius(10)
        }
        .padding()
    }
}

struct CharacterGridView: View {
    let character: Result
    
    var body: some View {
        VStack(alignment:.leading) {
            ImageLoadingView(url: character.image, key: "\(character.id)")
            
            HStack {
                Spacer(minLength: 0)
                Text(character.name)
                    .font(.rickyMortyFont)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .foregroundColor(.green)
                Spacer(minLength: 0)
            }
            HStack{
                Image(character.status)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(2)
                    .background(Circle().fill(Color.yellow))
                Text(character.status)
                    .foregroundColor(.white)
            }
            
            Text(character.species)
                .font(.title3)
                .foregroundColor(.white)
            
//            Text("Last known location:")
//                .font(.callout)
//                .foregroundColor(.black.opacity(0.6))
//            Text(character.location.name)
        }
        .padding()
        .background{
            Color(.white)
                .opacity(0.5)
                .cornerRadius(10)
        }
        .padding()
    }
}

struct CharacterView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView(character: Result(
            id: 1,
            name: "Testing",
            status: "Dead",
            species: "",
            type: "",
            gender: "",
            origin: Location(name: "", url: ""),
            location: Location(name: "", url: ""),
            image: "",
            episode: [],
            url: "",
            created: "")).previewLayout(.sizeThatFits)
    }
}
