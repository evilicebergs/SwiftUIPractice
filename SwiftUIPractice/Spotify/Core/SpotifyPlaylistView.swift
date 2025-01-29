//
//  SpotifyPlaylistView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-28.
//

import SwiftUI
import SwiftfulRouting

struct SpotifyPlaylistView: View {
    
    var product: Product = .mock
    var user: User = .mock
    
    @Environment(\.router) var router
    
    @State private var products: [Product] = []
    @State private var showheader: Bool = false
    
    var body: some View {
        ZStack {
            Color.spotifyBlack.ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    PlaylistHeaderCell(
                        height: 250,
                        title: product.title,
                        subtitle: product.description,
                        imageName: product.image
                    )
                    .readingFrame { frame in
                        showheader = frame.maxY < 150 ? true : false
                    }
                    
                    PlaylistDescriptionCell(
                        descriptionText: product.description,
                        userName: user.firstName,
                        subheadline: product.category,
                        onAddToPlaylistPressed: nil,
                        onDownloadPressed: nil,
                        onSharePressed: nil,
                        onEllipsPressed: nil,
                        onShufflePressed: nil,
                        onPlayPressed: nil
                    )
                    .padding(.horizontal, 16)
                    
                    ForEach(products) { product in
                        SongRowCell(
                            imageSize: 55,
                            imageName: product.image,
                            songname: product.title,
                            artist: product.brand,
                            onEllipsisClicked: nil,
                            onCellTapped: {
                                goToPlaylistView(product: product)
                            }
                        )
                        .padding(.leading, 16)
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            header
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .toolbar(.hidden, for: .navigationBar)
        .task {
            await getData()
        }
    }
    
    private func getData() async {
        do {
            products = try await DatabaseHelper().getProducts()
        } catch {
            print(error)
        }
    }
    
    private var header: some View {
        ZStack {
            Text(product.title)
                .font(.headline)
                .padding(.vertical, 20)
                .opacity(showheader ? 1 : 0)
                .offset(y: showheader ? 0 : -40)
            
            Image(systemName: "chevron.left")
                .font(.title3)
                .padding(10)
                .background(showheader ? .clear : .spotifyGray.opacity(0.7))
                .clipShape(.circle)
                .onTapGesture {
                    router.dismissScreen()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 16)
        }
        .foregroundStyle(.spotifyWhite)
        .frame(maxWidth: .infinity)
        .background(showheader ? .spotifyBlack : .clear)
        .animation(.smooth(duration: 0.2), value: showheader)
    }
    
    private func goToPlaylistView(product: Product) {
        router.showScreen(.push) { _ in
            SpotifyPlaylistView(product: product, user: user)
        }
    }
}

#Preview {
    RouterView { _ in
        SpotifyPlaylistView()
    }
}
