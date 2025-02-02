//
//  NetflixFilterBarView.swift
//  SwiftUIPractice
//
//  Created by Artem Golovchenko on 2025-02-02.
//

import SwiftUI

struct FilterModel: Hashable, Equatable {
    var title: String
    var isDropdown: Bool
    
    static var mockArray: [FilterModel] {
        [
            FilterModel(title: "TV Shows", isDropdown: false),
            FilterModel(title: "Movies", isDropdown: false),
            FilterModel(title: "Categories", isDropdown: true)
        ]
    }
}

struct NetflixFilterBarView: View {
    
    var filters: [FilterModel] = FilterModel.mockArray
    var xmarkClicked: (() -> Void)? = nil
    var onFilterClicked: ((FilterModel) -> Void)? = nil
    var selectedFilter: FilterModel? = nil
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                // if is selected
                if selectedFilter != nil {
                    Image(systemName: "xmark")
                        .padding(8)
                        .background(
                            Circle()
                                .stroke(lineWidth: 1)
                        )
                        .foregroundStyle(.netflixLightGray)
                        .background(.black.opacity(0.000001))
                        .onTapGesture {
                            xmarkClicked?()
                        }
                        .transition(.move(edge: .leading))
                        .padding(.leading, 16)
                        
                }
                ForEach(filters, id: \.hashValue) { filter in
                    if selectedFilter == nil || selectedFilter == filter {
                        NetflixFilterCell(
                            title: filter.title,
                            isDropdown: filter.isDropdown,
                            isSelected: selectedFilter == filter
                        )
                        .background(.black.opacity(0.00001))
                        .onTapGesture {
                            onFilterClicked?(filter)
                        }
                        .padding(.leading, ((selectedFilter == nil) && (filters[0] == filter)) ? 16 : 0)
                    }
                }
            }
            .padding(.vertical, 4)
        }
        .animation(.bouncy, value: selectedFilter)
        .scrollIndicators(.hidden)
    }
}

fileprivate struct NetflixFilterBarViewPreview: View {
    
    @State private var filters = FilterModel.mockArray
    @State private var selectedFilter: FilterModel? = nil
    
    
    var body: some View {
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
    }
}

#Preview {
    ZStack {
        Color.netflixBlack.ignoresSafeArea()
        NetflixFilterBarViewPreview()
    }
}
