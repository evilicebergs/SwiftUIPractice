//
//  NetflixHomeView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-02.
//

import SwiftUI

struct NetflixHomeView: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    @State private var fullHeaderHeight: CGFloat = 0
    @State private var heroProduct: Product? = nil
    
    @State private var currentUser: User? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            ScrollView(.vertical) {
                VStack(spacing: 8) {
                    Rectangle()
                        .frame(height: fullHeaderHeight)
                        .foregroundStyle(.clear)
                    if let heroProduct {
                        heroCell(product: heroProduct)
                    }
                    
                    categoryRows
                    
                }
            }
            .scrollIndicators(.hidden)
            
            VStack {
                header
                    .padding(.horizontal, 16)
                
                NetflixFilterBarView(
                    filters: filters,
                    xmarkClicked: {
                        selectedFilter = nil
                    },
                    onFilterClicked: { newFilter in
                        selectedFilter = newFilter
                    },
                    selectedFilter: selectedFilter
                )
                .padding(.top, 4)
                
            }
            .background(.blue)
            .readingFrame { frame in
                fullHeaderHeight = frame.height
            }
            
        }
        .foregroundStyle(.netflixWhite)
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            if products.isEmpty {
                currentUser = try await DatabaseHelper().getUsers().first
                products = try await Array(DatabaseHelper().getProducts().prefix(10))
                
                var rows: [ProductRow] = []
                let allBrands = Set(products.map({ $0.brand }))
                
                for brand in allBrands {
                    if let brand {
                        //let sortedProducts = products.filter { $0.brand == brand }
                        rows.append(ProductRow(title: brand.capitalized, products: products))
                    }
                }
                productRows = rows
                heroProduct = products.randomElement()
            }
        } catch {
            print(error)
        }
    }
    
    private var header: some View {
        HStack {
            Text("For You")
                .foregroundStyle(.netflixWhite)
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 16) {
                Image(systemName: "tv.badge.wifi")
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "magnifyingglass")
                    .onTapGesture {
                        
                    }
            }
            .font(.title2)
        }
    }
    
    private func heroCell(product: Product) -> some View {
            NetflixNewReleaseCell(
                title: product.title,
                imageName: product.image,
                isNetfixFilm: Bool.random(),
                categories: [product.category.capitalized, product.brand ?? ""]) {
                    
                } onPlayPressed: {
                    
                } onMyListPressed: {
                    
                }
        }
    
    private var categoryRows: some View {
        LazyVStack(spacing: 16) {
            ForEach(productRows) { row in
                VStack(alignment: .leading, spacing: 6) {
                    Text(row.title)
                        .font(.headline)
                        .padding(.leading, 16)
                    
                    ScrollView(.horizontal) {
                        LazyHStack {
                            ForEach(Array(row.products.enumerated()), id: \.offset) { (index, product) in
                                NetflixRowCell(
                                    imageName: product.image,
                                    title: product.title,
                                    isRecentlyAdded: product.recentlyAdded,
                                    topTenRanking: row.id == productRows[2].id ? index + 1 : nil
                                )
                            }
                        }
                        .padding(.leading, 16)
                    }
                    .scrollIndicators(.hidden)
                }
            }
        }
    }
}

#Preview {
    NetflixHomeView()
}
