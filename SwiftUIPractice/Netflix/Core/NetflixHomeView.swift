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
                        NetflixNewReleaseCell(
                            title: heroProduct.title,
                            imageName: heroProduct.image,
                            isNetfixFilm: Bool.random(),
                            categories: [heroProduct.category.capitalized, heroProduct.brand ?? ""]) {
                                
                            } onPlayPressed: {
                                
                            } onMyListPressed: {
                                
                            }

                    }
                    
                    ForEach(0..<20) { _ in
                        Rectangle()
                            .fill(.netflixRed)
                            .frame(height: 200)
                    }
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
}

#Preview {
    NetflixHomeView()
}
