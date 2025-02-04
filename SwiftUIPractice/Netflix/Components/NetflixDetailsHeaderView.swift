//
//  NetflixDetailsHeaderView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-04.
//

import SwiftUI
import SwiftfulUI

struct NetflixDetailsHeaderView: View {
    
    var image: String = Constants.randomImage
    var progress: Double = 0.2
    
    var airPlayPressed: (() -> Void)? = nil
    var xmarkPressed: (() -> Void)? = nil
    
    var body: some View {
        ZStack(alignment: .trailing) {
            ImageLoaderView(urlString: image)
            
            VStack(alignment: .trailing) {
                HStack(spacing: 8) {
                    Circle()
                        .foregroundStyle(.netflixDarkGray)
                        .frame(width: 40, height: 40)
                        .overlay {
                            Image(systemName: "tv.badge.wifi")
                                .fontWeight(.semibold)
                                .offset(y: 1)
                        }
                        .onTapGesture {
                            airPlayPressed?()
                        }
                    
                    Circle()
                        .foregroundStyle(.netflixDarkGray)
                        .overlay {
                            Image(systemName: "xmark")
                                .fontWeight(.semibold)
                        }
                        .frame(width: 36, height: 36)
                        .onTapGesture {
                            xmarkPressed?()
                        }

                }
                .foregroundStyle(.netflixWhite)
                .padding(8)
                
                Spacer()
                
                CustomProgressBar(
                    selection: progress,
                    range: 0...1,
                    backgroundColor: .netflixLightGray.opacity(0.4),
                    foregroundColor: .netflixRed,
                    cornerRadius: 2,
                    height: 4
                )
                .padding(.bottom, 8)
                .animation(.linear, value: progress)
                
                
            }
        }
        .aspectRatio(2, contentMode: .fit)
    }
}

#Preview {
    NetflixDetailsHeaderView()
}
