//
//  NetflixMovieDetailScreen.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-04.
//

import SwiftUI
import SwiftfulRouting

struct NetflixMovieDetailScreen: View {
    
    var product: Product = .mock
    
    @Environment(\.router) var router
    
    @State private var progress: Double = 0.2
    @State private var isInMyList: Bool = false
    
    @State private var products: [Product] = []
    
    var body: some View {
        ZStack {
            Color.netflixBlack.ignoresSafeArea()
            Color.netflixDarkGray.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                NetflixDetailsHeaderView(
                    image: product.image,
                    progress: progress) {
                        
                    } xmarkPressed: {
                        router.dismissScreen()
                    }
                
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        detailsProductSection
                        
                        buttonsSection
                        
                        gridSection
                        
                    }
                    .padding(8)

                }
                .scrollIndicators(.hidden)

                
            }
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        do {
            if products.isEmpty {
               // currentUser = try await DatabaseHelper().getUsers().first
                products = try await Array(DatabaseHelper().getProducts().prefix(10))
            }
        } catch {
            print(error)
        }
    }
    
    private var detailsProductSection: some View {
        NetflixDetailsProducView(
            title: product.title,
            isNew: true,
            yearReleased: "2023",
            seasonsCount: product.stock,
            hasClosedCaptions: true,
            isTopTen: 3,
            descriptionText: product.description,
            castText: product.brand) {
                
            } onDownloadPressed: {
                
            }
    }
    
    private var buttonsSection: some View {
        HStack(spacing: 32) {
            MyListButton(isInMyList: isInMyList) {
                isInMyList.toggle()
            }
            RateButton { selection in
                
            }
            
            ShareButton()
        }
        .padding(.leading, 32)
    }
    
    private var gridSection: some View {
        VStack(alignment: .leading) {
            Text("More Like This")
                .font(.headline)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                ForEach(products) { product in
                    NetflixRowCell(
                        imageName: product.image,
                        title: product.title,
                        isRecentlyAdded: product.recentlyAdded,
                        topTenRanking: nil
                    )
                    .onTapGesture {
                        router.showScreen(.sheet) { _ in
                            NetflixMovieDetailScreen(product: product)
                        }
                    }
                }
            }
        }
        .foregroundStyle(.netflixWhite)
    }
    
}

#Preview {
    RouterView { _ in
        NetflixMovieDetailScreen()
    }
}
