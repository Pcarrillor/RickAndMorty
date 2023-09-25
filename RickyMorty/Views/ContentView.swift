//
//  ContentView.swift
//  RickyMorty
//
//  Created by Admin on 22/09/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var navPath: [Any] = []
    @State var page = "Characters"
    var body: some View {
        NavigationStack {
            ZStack{
                if page == "Characters"{
                    CharactersView()
                        .navigationDestination(for: Result.self) { value in
                            CharacterDetailView(character: value)
                        }.navigationDestination(for: Location.self) { value in
                            Text(value.name)
                        }
                } else if page == "Locations" {
                    Text("Locations")
                        .navigationDestination(for: Location.self) { value in
                            Text(value.name)
                        }
                } else if page == "Episodes" {
                    Text("Episodes")
                        .navigationDestination(for: Location.self) { value in
                            Text(value.name)
                        }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 50)
                }
            }
//            .toolbarTitleMenu {
//                Button {
//                    page = "Characters"
//                } label: {
//                    Text("Characters")
//                }
//                Button {
//                    page = "Locations"
//                } label: {
//                    Text("Locations")
//                }
//                Button {
//                    page = "Episodes"
//                } label: {
//                    Text("Episodes")
//                }
//            }
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
