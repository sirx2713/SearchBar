//
//  ContentView.swift
//  SearchBar
//
//  Created by Tafadzwa Alexander Razaro on 2024/06/07.
//

import SwiftUI

struct ContentView: View {

    @State private var searchText: String = ""

    enum Month: String, Identifiable, CaseIterable, CustomStringConvertible {
        var id: UUID {
            UUID()
        }

        var description: String {
            self.rawValue.localizedCapitalized
        }

        case january, february
        case march, april, may
        case june, july, august
        case september, october, november
        case december
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(
                    Month.allCases.filter {
                        searchText.isEmpty || $0.rawValue.contains(searchText.lowercased())
                    }
                ) { month in
                    Text(month.description)
                }
            }
            #if os(macOS)
            .searchable(text: $searchText, placement: .toolbar)
            #else
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            #endif
            .searchSuggestions {
                ForEach(Month.allCases) { month in
                    if month.description.contains(searchText.localizedCapitalized) {
                        Text(month.description)
                            .searchCompletion(month.description)
                    }
                }
            }
            .navigationTitle("Search")
        }
    }
}
#Preview {
    ContentView()
}
