//
//  NetflixHomeView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-02.
//

import SwiftUI
import SwiftfulUI

struct NetflixHomeView: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    @State private var fullHeaderHeight: CGFloat = 0
    @State private var heroProduct: Product? = nil
    
    @State private var currentUser: User? = nil
    @State private var products: [Product] = []
    @State private var productRows: [ProductRow] = []
    
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.netflixBlack.ignoresSafeArea()
            
            gradientLayer
            
            scrollView
            
            fullHeader
            
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
                        rows.append(ProductRow(title: brand.capitalized, products: products.shuffled()))
                    }
                }
                productRows = rows
                heroProduct = products.randomElement()
            }
        } catch {
            print(error)
        }
    }
    
    private var scrollView: some View {
        ScrollViewWithOnScrollChanged(.vertical, showsIndicators: false) {
            VStack(spacing: 8) {
                Rectangle()
                    .frame(height: fullHeaderHeight)
                    .foregroundStyle(.clear)
                if let heroProduct {
                    heroCell(product: heroProduct)
                }
                
                categoryRows
                
            }
        } onScrollChanged: { offset in
            scrollViewOffset = min(0, offset.y)
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
    
    private var gradientLayer: some View {
        ZStack {
            LinearGradient(colors: [.netflixDarkRed, .netflixBlack], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
        .frame(maxHeight: max(10, 400 + scrollViewOffset * 0.75))
        .opacity(scrollViewOffset < -300 ? 0 : 1)
        .animation(.easeInOut, value: scrollViewOffset)
    }
    
    private var fullHeader: some View {
        VStack {
            header
                .padding(.horizontal, 16)
            
            if scrollViewOffset > -30 {
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
                .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding(.bottom, 8)
        .background(
            ZStack {
                if scrollViewOffset < -70 {
                    Rectangle()
                        .fill(.ultraThinMaterial)
                        .brightness(-0.2)
                        .ignoresSafeArea()
                }
            }
        )
        .animation(.smooth, value: scrollViewOffset)
        .readingFrame { frame in
            if fullHeaderHeight == 0 {
                fullHeaderHeight = frame.height
            }
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
