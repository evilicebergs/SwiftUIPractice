//
//  BumbleCardView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-30.
//

import SwiftUI
import SwiftfulUI

struct BumbleCardView: View {
    
    var user: User = .mock
    var onSuperLikePressed: (() -> Void)? = nil
    var onXMarkPressed: (() -> Void)? = nil
    var onCheckmarkPressed: (() -> Void)? = nil
    var onSendComplimentPressed: (() -> Void)? = nil
    var onHideAndReportPressed: (() -> Void)? = nil
    
    @State private var cardFrame: CGRect = .zero
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack(spacing: 0) {
                
                headerCell
                    .frame(height: cardFrame.height)
                
                aboutMe
                    .padding(.vertical, 24)
                    .padding(.horizontal, 24)
                
                locationSection
                    .padding(.vertical, 8)
                    .padding(.horizontal, 24)
                
                myInterestsSection
                    .padding(.vertical, 8)
                    .padding(.horizontal, 24)
                
                ForEach(user.images, id: \.self) { image in
                    ImageLoaderView(urlString: image)
                        .frame(height: cardFrame.height)
                }
                
                footerSection
                    .padding(.top, 60)
                    .padding(.bottom, 60)
                    .padding(.horizontal, 32)
                
                
            }
        }
        .scrollIndicators(.hidden)
        .background(.bumbleBackgroundYellow)
        .overlay(alignment: .bottomTrailing, content: {
            superLikeButton
                .padding(24)
                
        })
        .clipShape(.rect(cornerRadius: 36))
        .readingFrame { frame in
            cardFrame = frame
        }
    }
    
    private var superLikeButton: some View {
        Image(systemName: "hexagon.fill")
            .foregroundStyle(.bumbleYellow)
            .font(.system(size: 60))
            .overlay {
                Image(systemName: "star.fill")
                    .foregroundStyle(.bumbleBlack)
                    .font(.system(size: 30))
                    .fontWeight(.medium)
            }
            .onTapGesture {
                onSuperLikePressed?()
            }
    }
    
    private func sectionTitle(title: String) -> some View {
        Text(title)
            .font(.body)
            .foregroundStyle(.bumbleGray)
    }
    
    private var footerSection: some View {
        VStack(spacing: 24) {
            HStack(spacing: 0) {
                Image(systemName: "xmark")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                    .background(.bumbleYellow)
                    .clipShape(.circle)
                    .onTapGesture {
                        onXMarkPressed?()
                    }
                
                Spacer(minLength: 0)
                
                Circle()
                    .fill(.bumbleYellow)
                    .frame(width: 60, height: 60)
                    .overlay {
                        Image(systemName: "checkmark")
                            .font(.title)
                            .fontWeight(.semibold)
                    }
                    .onTapGesture {
                        onCheckmarkPressed?()
                    }
            }
            .foregroundStyle(.bumbleBlack)
            
            Text("Hide and Report")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleGray)
                .padding(8)
                .background(.black.opacity(0.0000001))
                .onTapGesture {
                    onHideAndReportPressed?()
                }
        }
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: "mappin.and.ellipse.circle.fill")
                Text(user.firstName + "'s Location")
            }
            .foregroundStyle(.bumbleGray)
            .font(.body)
            .fontWeight(.medium)
            
            Text("10 Miles Away")
                .font(.headline)
                .foregroundStyle(.bumbleBlack)
            
            InterestPillView(iconName: nil, emojiName: "🇺🇸", title: "Lives in New York, NY")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var aboutMe: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle(title: "About Me")
            
            Text(user.aboutMe)
                .font(.body)
                .fontWeight(.semibold)
                .foregroundStyle(.bumbleBlack)
            
            HStack(spacing: 0) {
                BumbleHeartView()
                
                Text("Send a Compliment")
                    .foregroundStyle(.bumbleBlack)
                    .font(.caption)
                    .fontWeight(.semibold)
            }
            .padding(.leading, 8)
            .padding(.trailing, 16)
            .background(.bumbleYellow)
            .clipShape(.rect(cornerRadius: 36))
            .onTapGesture {
                onSendComplimentPressed?()
            }
            
        }
    }
    
    private var myInterestsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My basics")
                
                InterestPillGridView(interests: user.basics)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                sectionTitle(title: "My interests")
                
                InterestPillGridView(interests: user.interests)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var headerCell: some View {
        ZStack(alignment: .bottomLeading) {
            ImageLoaderView(urlString: user.image)
               
            VStack(alignment: .leading, spacing: 8) {
                Text("\(user.firstName), \(user.age)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                HStack(spacing: 4) {
                    Image(systemName: "suitcase")
                    
                    Text(user.work)
                }
                HStack(spacing: 4) {
                    Image(systemName: "graduationcap")
                    
                    Text(user.education)
                }
                
                BumbleHeartView()
                    .onTapGesture {
                        
                    }
            }
            .padding(24)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(.bumbleWhite)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [
                        .bumbleBlack.opacity(0),
                        .bumbleBlack.opacity(0.6),
                        .bumbleBlack.opacity(0.6)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            
        }
    }
    
}

#Preview {
    
    BumbleCardView()
        .padding(.vertical, 40)
        .padding(.horizontal, 16)
}
