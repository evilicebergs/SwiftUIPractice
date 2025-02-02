//
//  BumbleChatsView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-02.
//

import SwiftUI
import SwiftfulRouting

struct BumbleChatsView: View {
    
    @Environment(\.router) var router
    @State private var allUsers: [User] = []
    
    var body: some View {
        ZStack(alignment: .top) {
            Color.bumbleWhite.ignoresSafeArea()
            VStack {
                header
                    .padding(16)
                
                matchQueueSection
                
                recentChatsView
            }
            
        }
        .task {
            await getData()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }
    
    private func getData() async {
        guard allUsers.isEmpty else { return }
        do {
            allUsers = try await DatabaseHelper().getUsers()
        } catch {
            print(error)
        }
    }
    
    private var header: some View {
        HStack {
            Image(systemName: "line.3.horizontal")
                .padding(4)
                .background(.black.opacity(0.00000001))
                .onTapGesture {
                    router.dismissScreen()
                }
            
            Spacer()
            
            Image(systemName: "magnifyingglass")
                .padding(4)
                .background(.black.opacity(0.00000001))
                .onTapGesture {
                    
                }

        }
        .font(.title)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
    private var matchQueueSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Group {
                Text("Match Queue ")
                +
                Text("(\(allUsers.count))")
                    .foregroundStyle(.bumbleGray)
            }
            .foregroundStyle(.bumbleBlack)
            .padding(.horizontal, 16)
        
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(allUsers) { user in
                        BumbleProfileImageCell(
                            imageName: user.image,
                            percentageRemaining: Double.random(in: 0.0...1.0),
                            hasNewMessage: Bool.random(),
                            cellSize: 75
                        )
                        .padding(.horizontal, 2)
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(height: 100)
            .scrollIndicators(.hidden)
        }
    }
    
    private var recentChatsView: some View {
        VStack {
            HStack {
                Group {
                    Text("Chats ")
                    +
                    Text("(Recent)")
                        .foregroundStyle(.bumbleGray)
                }
                .foregroundStyle(.bumbleBlack)
                
                Spacer()
                
                Image(systemName: "line.3.horizontal.decrease")
                    .padding(4)
                    .background(.bumbleGray.opacity(0.00000001))
                    .fontWeight(.semibold)
                    .onTapGesture {
                        
                    }
            }
            .padding(.horizontal, 16)
            
            ScrollView(.vertical) {
                VStack {
                    ForEach(allUsers, id: \.id) { user in
                        BumbleChatPreviewCell(
                            userName: user.firstName,
                            imageName: user.images.randomElement()!,
                            recentMessage: "Hi, I'm a test message",
                            yourMove: Bool.random()
                        )
                        
                    }
                    .padding(2)
                    .padding(.horizontal, 16)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
}

#Preview {
    RouterView { _ in
        BumbleChatsView()
    }
}
