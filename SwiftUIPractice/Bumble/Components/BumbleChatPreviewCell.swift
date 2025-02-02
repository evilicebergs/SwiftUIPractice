//
//  BumbleChatPreviewCell.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-01-31.
//

import SwiftUI

struct BumbleChatPreviewCell: View {
    
    var userName: String = "Terry"
    var imageName: String = Constants.randomImage
    var recentMessage: String? = "Hi, how are you doing blah blah vlah hksjgjk jskhfkjsh skjhfkj ?"
    
    var yourMove: Bool = true
    
    var body: some View {
        HStack(spacing: 16) {
            BumbleProfileImageCell(cellSize: 75)
            
            VStack(alignment: .leading, spacing: 2) {
                HStack {
                    Text(userName)
                        .fontWeight(.semibold)
                        .font(.headline)
                        .foregroundStyle(.bumbleBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                   
                    if yourMove {
                        Text("YOUR MOVE")
                            .fontWeight(.semibold)
                            .foregroundStyle(.bumbleBlack)
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.bumbleYellow)
                            .clipShape(.rect(cornerRadius: 36))
                            //.offset(x: -12)
                    }
                }
                if let recentMessage {
                    Text(recentMessage)
                        .foregroundStyle(.bumbleGray)
                        .lineLimit(1)
                        .padding(.trailing, 16)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BumbleChatPreviewCell()
        .padding()
}
