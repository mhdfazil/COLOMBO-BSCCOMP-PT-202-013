//
//  SearchBar.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-16.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @State var isEditing = false
    
    var body: some View {
        HStack {
            TextField("Search ...", text: $searchText)
                .padding(10)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(Color.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 10)
                        
                        if isEditing {
                            Button(action: {
                                self.searchText = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(Color.gray)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }
                .keyboardType(.webSearch)
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.searchText = ""
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {
                    Text("Cancel")
                }
                .padding(.trailing, 10)
            } else {
                Button(action: {
                    
                }) {
                    Image(systemName: "slider.horizontal.3")
                        .padding(.trailing, 10)
                }
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text = ""
    static var previews: some View {
        SearchBar(searchText: $text)
    }
}
