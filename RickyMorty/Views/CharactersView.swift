//
//  CharactersView.swift
//  RickyMorty
//
//  Created by Admin on 24/09/23.
//

import SwiftUI
import Combine

struct CharactersView: View {
    @State var characters: CharactersModel?
    @State var page = 1
    @State var multiview : Bool = false
    @State var search: String = ""
    var body: some View {
        NavigationStack {
            VStack {
                HStack{
                    TextField(text: $search) {
                        Text("Buscar").foregroundColor(.black.opacity(0.4)).padding()
                    }
                    .foregroundColor(.white)
                    .padding(6)
                    .background(Color.white.opacity(0.5).cornerRadius(5))
                    
                    
                    Button {
                        multiview = true
                    } label: {
                        Image(systemName:  multiview ? "square.grid.2x2.fill" : "square.grid.2x2").resizable().scaledToFit()
                    }.frame(width:30, height: 30)
                    
                    Button {
                        multiview = false
                    } label: {
                        Image(systemName: multiview ? "rectangle.grid.1x2" : "rectangle.grid.1x2.fill").resizable().scaledToFill()
                    }.frame(width:30,height:30)
                }.foregroundColor(.gray).padding(.horizontal).padding(.top)
                
                ScrollView {
                    LazyVGrid(columns: multiview ? [GridItem(),GridItem()] : [GridItem()]) {
                        ForEach((characters?.results) ?? [], id: \.self) { character in
                            NavigationLink(value: character) {
                                ZStack{
                                    if multiview {
                                        CharacterGridView(character: character)
                                    } else {
                                        CharacterView(character: character)
                                    }
                                }
                                .onAppear{
                                    let index = characters?.results.firstIndex(of: character)
                                    if index == (characters?.results.count ?? 1) - 1  && page < (characters?.info.pages)! {
                                        self.page += 1
                                        getCharacters(page: page)
                                    }
                                }
                                .onChange(of: search) { _ in
                                    page = 1
                                    getCharacters(page: page)
                                }
                            }
                        }
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .onAppear{
                if page == 1 {
                    getCharacters(page: page)
                }
            }
            .navigationTitle("Characters")
            .background{
                Color.black.ignoresSafeArea()
            }
        }
    }
    
    func getCharacters(page:Int) {
        var cancellables = Set<AnyCancellable>()
        
        let url = URL(string: "\(getCharacter)?page=\(page)&name=\(search.lowercased().replacingOccurrences(of: " ", with: "%20"))&status=&species=&type=&gender=")
        // Create the url request
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // the request is JSON
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // the response expected to be in JSON format
        
        URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    let dataResponse: String = String(data: data, encoding: .utf8) ?? "Error proceso"
                    debugPrint("Error: " + dataResponse)
                    debugPrint(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: CharactersModel.self, decoder: JSONDecoder())
            .sink { (completion) in
                debugPrint("Completion: \(completion)")
            } receiveValue: { response in
                //                print(response)
                if page == 1 {
                    characters = response
                } else {
                    self.characters?.results.append(contentsOf: response.results)
                }
                print(self.page)
            }
            .store(in: &cancellables)
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersView()
    }
}
