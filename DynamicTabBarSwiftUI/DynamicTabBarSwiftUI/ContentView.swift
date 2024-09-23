//
//  ContentView.swift
//  DynamicTabBarSwiftUI
//
//  Created by Kishore B on 9/23/24.
//

import SwiftUI

struct TabItem: Identifiable, Hashable {
    var id = UUID()
    var title: String
    var imageName: String
}


struct ContentView: View {
 
        @State private var tabItems = [
            TabItem(title: "Home", imageName: "house"),
            TabItem(title: "Search", imageName: "magnifyingglass"),
            TabItem(title: "Favorites", imageName: "star"),
            TabItem(title: "Settings", imageName: "gear"),
            TabItem(title: "Profile", imageName: "person")
        ]
        
        @State private var moreItems = [
            TabItem(title: "Downloads", imageName: "arrow.down.circle"),
            TabItem(title: "Messages", imageName: "message"),
            TabItem(title: "Notifications", imageName: "bell")
        ]
        
        @State private var isMorePresented = false
        
        var body: some View {
            TabView {
                ForEach(tabItems.prefix(4), id: \.self) { item in
                    Text(item.title)
                        .tabItem {
                            Image(systemName: item.imageName)
                            Text(item.title)
                        }
                }
                
                Button {
                    isMorePresented.toggle()
                } label: {
                    Text("More")
                }
                .tabItem {
                    Image(systemName: "ellipsis.circle")
                    Text("More")
                }
            }
            .sheet(isPresented: $isMorePresented) {
                ReorderTabItemsView(tabItems: $tabItems, moreItems: $moreItems)
            }
        }
    }




struct ReorderTabItemsView: View {
    @Binding var tabItems: [TabItem]
    @Binding var moreItems: [TabItem]
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Tab Bar Items")) {
                    ForEach(tabItems) { item in
                        Text(item.title)
                    }
                    .onMove(perform: moveTabItems)
                }
                
                Section(header: Text("More Items")) {
                    ForEach(moreItems) { item in
                        Text(item.title)
                    }
                    .onMove(perform: moveMoreItems)
                }
            }
            .toolbar {
                EditButton()
            }
            .navigationTitle("Reorder Items")
        }
    }
    
    // Function to move items within the Tab Items section
    private func moveTabItems(from source: IndexSet, to destination: Int) {
        tabItems.move(fromOffsets: source, toOffset: destination)
    }
    
    // Function to move items within the More Items section
    private func moveMoreItems(from source: IndexSet, to destination: Int) {
        moreItems.move(fromOffsets: source, toOffset: destination)
    }
}


#Preview {
    ContentView()
}
