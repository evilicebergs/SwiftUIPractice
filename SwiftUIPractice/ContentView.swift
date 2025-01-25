//
//  ContentView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-25.
//

import SwiftUI
import SwiftfulRouting
import SwiftfulUI

struct ContentView: View {
    
    @State private var users: [User] = []
    @State private var products: [Product] = []
    
    var body: some View {
        List {
            ForEach(products, id: \.id) { product in
                Text(product.title)
            }
        }
        .padding()
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        do {
            users = try await DatabaseHelper().getUsers()
            products = try await DatabaseHelper().getProducts()
        } catch {
            print(error)
        }
    }
    
}

#Preview {
    ContentView()
}
