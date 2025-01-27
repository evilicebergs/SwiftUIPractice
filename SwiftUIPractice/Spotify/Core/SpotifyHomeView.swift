//
//  SpotifyHomeView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-27.
//

import SwiftUI
import SwiftfulUI

struct SpotifyHomeView: View {
    
    @State private var currentUser: User? = nil
    @State private var selectedCategory: Category = .all
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 16) {
                            recentsView
                            if let product = products.first {
                                newReleaseSection(product)
                            }
                        }
                        .padding(.horizontal, 16)
                        
                        ForEach(0..<20) { _ in
                            Rectangle()
                                .frame(width: 200, height: 200)
                                .foregroundStyle(.red)
                        }
                    } header: {
                        header
                    }
                }
                .padding(.top, 8)
            }
            .scrollIndicators(.hidden)
            .clipped()
        }
        .task {
            await getData()
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            currentUser = try await DatabaseHelper().getUsers().first
            products = try await Array(DatabaseHelper().getProducts().prefix(8))
        } catch {
            print(error)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            ZStack {
                if let currentUser {
                    ImageLoaderView(urlString: currentUser.image)
                        .background(.spotifyWhite)
                        .clipShape(.circle)
                        .onTapGesture {
                            
                        }
                }
            }
            .frame(width: 35, height: 35)
        
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    ForEach(Category.allCases, id: \.self) { category in
                        SpotifyCategoryCell(title: category.rawValue.capitalized, isSelected: category == selectedCategory)
                            .onTapGesture {
                                selectedCategory = category
                            }
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
            
        }
        .padding(.vertical, 24)
        .padding(.leading, 8)
        .background(.spotifyBlack)
    }
    
    private var recentsView: some View {
        NonLazyVGrid(columns: 2, alignment: .center, spacing: 10, items: products) { product in
            if let product {
                SpotifyRecentsCell(imageName: product.image, title: product.title)
            }
        }
    }
    
    private func newReleaseSection(_ firstProduct: Product) -> some View {
           return SpotifyNewReleaseCell(
                imageName: firstProduct.image,
                headline: firstProduct.brand,
                subheadline: firstProduct.category?.capitalized,
                title: firstProduct.title,
                subtitle: firstProduct.description,
                onAddToPlaylistPressed: {
                    
                },
                onPlayPressed:  {
                    
                })
    }
    
}

#Preview {
    SpotifyHomeView()
}
