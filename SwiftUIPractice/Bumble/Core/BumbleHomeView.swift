//
//  BumbleHomeView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-29.
//

import SwiftUI

struct BumbleHomeView: View {
    
    @State private var options: [String] = ["Everyone", "Trending"]
    @AppStorage("selected_filter") private var selectedFilter: String = "Everyone"
    
    var body: some View {
        ZStack {
            Color.bumbleWhite.ignoresSafeArea()
            
            VStack(spacing: 8) {
                header
                
                BumbleFilterView(options: options, selection: $selectedFilter)
                    .background(
                        Divider(), alignment: .bottom
                    )
                
                Spacer()
            }
            .padding(8)
        }
    }
    
    private var header: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                Image(systemName: "line.horizontal.3")
                    .padding(8)
                    .background(.black.opacity(0.0000001))
                    .onTapGesture {
                        
                    }
                
                Image(systemName: "arrow.uturn.left")
                    .padding(8)
                    .background(.black.opacity(0.0000001))
                    .onTapGesture {
                        
                    }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("bumble")
                .font(.title)
                .foregroundStyle(.bumbleYellow)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Image(systemName: "slider.horizontal.3")
                .padding(8)
                .background(.black.opacity(0.0000001))
                .onTapGesture {
                    
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .font(.title2)
        .fontWeight(.medium)
        .foregroundStyle(.bumbleBlack)
    }
    
}

#Preview {
    BumbleHomeView()
}
