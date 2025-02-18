//
//  ContentView.swift
//  FridgeAdministration
//
//  Created by Levent Aydogan on 11.02.25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "house")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Tobias ist toll und kann bb")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
