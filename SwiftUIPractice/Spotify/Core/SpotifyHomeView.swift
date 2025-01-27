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
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()

            ScrollView {
                LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                    Section {
                        VStack(spacing: 16) {
                            recentsView
                                .padding(.horizontal, 16)
                            if let product = products.first {
                                newReleaseSection(product)
                                    .padding(.horizontal, 16)
                            }
                            
                            listRows
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
            
            var rows: [ProductRow] = []
            let allBrands = Set(products.map({ $0.brand }))
            
            for brand in allBrands {
                if let brand {
                    //let sortedProducts = products.filter { $0.brand == brand }
                    rows.append(ProductRow(title: brand.capitalized, products: products))
                }
            }
            
            productRows = rows
            print(productRows[0].products[0].image)
            
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
                    .asButton(.press) {
                        
                    }
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
    
    private var listRows: some View {
        ForEach(productRows) { row in
            VStack(spacing: 8) {
                Text(row.title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.spotifyWhite)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(row.products) { product in
                            ImageTitleRow(
                                imageSize: 120,
                                imageName: product.image,
                                productName: product.title
                            )
                            .asButton(.press) {
                                
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
                .scrollIndicators(.hidden)
            }
        }
    }
    
}

#Preview {
    SpotifyHomeView()
}
