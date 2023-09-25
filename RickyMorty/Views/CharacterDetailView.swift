//
//  CharacterDetailView.swift
//  RickyMorty
//
//  Created by Admin on 24/09/23.
//

import SwiftUI

struct CharacterDetailView: View {
    @State var character: Result
    @State private var imageScale: CGFloat = 1
    @State private var imageOffset: CGSize = .zero
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Text(character.name)
                    .font(.rickyMortyFontTitle)
                    .minimumScaleFactor(0.1)
                    .lineLimit(1)
                    .foregroundColor(.green)
                Spacer()
            }
            ImageLoadingView(url: character.image, key: "\(character.id)")
                .padding()
                .scaleEffect(imageScale)
                .offset(imageOffset)
                .zIndex(4)
            //MARK: TAP GESTURE
                .onTapGesture(count: 2) {
                    if imageScale == 1 {
                        withAnimation(.spring()){
                            imageScale = 2
                        }
                    } else {
                        resetImageState()
                    }
                }
            //MARK: DRAG GESTURE
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            //                            withAnimation(.linear(duration: 1)) {
                            if imageScale > 1 {
                                imageOffset = gesture.translation
                            }
                            //                            }
                        }
                        .onEnded { _ in
                            if imageScale <= 1 {
                                resetImageState()
                            }
                        }
                )
            //MARK: MAGNIFICATION
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            withAnimation(.linear(duration: 0.2)) {
                                if imageScale >= 1 && imageScale <= 2 {
                                    imageScale = value
                                } else if imageScale > 2 {
                                    imageScale = 2
                                }  else if imageScale < 1 {
                                    resetImageState()
                                }
                            }
                        }
                        .onEnded {_ in
                            if imageScale > 2 {
                                imageScale = 2
                            } else if imageScale < 1 {
                                resetImageState()
                            }
                        }
                )
            
            HStack {
                Spacer()
                Text("Character Details").font(.title)
                Spacer()
            }
            VStack(alignment: .leading) {
                Text("Gender")
                    .font(.title3)
                    .foregroundColor(.gray)
                Text(character.gender)
                Text("Species")
                    .font(.title3)
                    .foregroundColor(.gray)
                Text(character.species)
                Text("Last Known Location")
                    .font(.title3)
                    .foregroundColor(.gray)
//                NavigationLink(value: character.location) {
                    Text(character.location.name)
//                        .onTapGesture {
//                            NavigationPath.append(character.location)
//                        }
//                }
                Text("Origin")
                    .font(.title3)
                    .foregroundColor(.gray)
                Text(character.origin.name)
            }
            Spacer()
        }
        .padding()
//        .navigationTitle(character.name)
//        .toolbar(.hidden)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(character: Result(
            id: 1,
            name: "Testing",
            status: "Dead",
            species: "",
            type: "",
            gender: "",
            origin: Location(name: "", url: ""),
            location: Location(name: "", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [],
            url: "",
            created: ""))
    }
}
