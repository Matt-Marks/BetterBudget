//
//  SidebarView.swift
//  BetterBudget
//
//  Created by Matt Marks on 12/13/20.
//

import SwiftUI

struct SidebarView: View {
    
    @State var selected: Int? = 0
    
    var body: some View {
        List {
            Section(header: Text("Better Budget")) {
                NavigationLink(
                    destination: Text("Dashboard"),
                    tag: 0,
                    selection: $selected,
                    label: {
                        Label("Dashboard", systemImage: "gauge" )
                    })
            }
            Section(header: Text("Data")) {
                NavigationLink(
                    destination: Text("Recurring"),
                    tag: 1,
                    selection: $selected,
                    label: {
                        Label("Recurring", systemImage: "repeat")
                    })
                NavigationLink(
                    destination: Text("Spending"),
                    tag: 2,
                    selection: $selected,
                    label: {
                        Label("Spending", systemImage: "creditcard")
                    })
                NavigationLink(
                    destination: Text("Assets"),
                    tag: 3,
                    selection: $selected,
                    label: {
                        Label("Assets", systemImage: "chart.bar")
                    })
            }
            
        }
        .listStyle(SidebarListStyle())
        .navigationTitle("Better Budget")
    }
}

struct SidebarView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarView()
    }
}
