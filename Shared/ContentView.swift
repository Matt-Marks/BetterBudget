//
//  ContentView.swift
//  Shared
//
//  Created by Matt Marks on 12/13/20.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        NavigationView {
            SidebarView()
        }
        .navigationViewStyle(DoubleColumnNavigationViewStyle())
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
