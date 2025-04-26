//
//  FilterPage.swift
//  Lunch Roulette
//
//  Created by Amina Yegenberdiyeva on 26.04.2025.
//

import SwiftUI

struct FlowLayout<Content: View>: View {
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: () -> Content

    init(spacing: CGFloat = 10, alignment: HorizontalAlignment = .leading, @ViewBuilder content: @escaping () -> Content) {
        self.spacing = spacing
        self.alignment = alignment
        self.content = content
    }

    var body: some View {
        LazyVStack(alignment: alignment, spacing: spacing) {
            var width = CGFloat.zero
            var height = CGFloat.zero
            
            GeometryReader { geometry in
                ZStack(alignment: .topLeading) {
                    content()
                        .background(
                            GeometryReader { itemGeometry in
                                Color.clear.onAppear {
                                    width = max(width, itemGeometry.frame(in: .local).maxX)
                                    height = max(height, itemGeometry.frame(in: .local).maxY)
                                }
                            }
                        )
                        .frame(width: geometry.size.width, alignment: .leading)
                }
            }
            .frame(height: height)
        }
    }
}

struct PriceButton: View {
    var title: String
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(isSelected ? Color.orange : Color.gray.opacity(0.3))
            .foregroundColor(isSelected ? .white : .black)
            .cornerRadius(20)
    }
}

struct CuisineButton: View {
    var title: String
    var isSelected: Bool = false
    
    var body: some View {
        PriceButton(title: title, isSelected: isSelected)
    }
}

struct TimeButton: View {
    var title: String
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .padding(12)
            .overlay(
                Circle()
                    .strokeBorder(isSelected ? Color.orange : Color.gray, lineWidth: 2)
            )
            .background(
                Circle()
                    .fill(Color.white)
            )
            .foregroundColor(.black)
    }
}

struct FilterPage: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Lunch Roulette")
                .font(.largeTitle)
                .bold()
                .padding(.top, 40)
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Средний чек")
                    .font(.headline)
                
                FlowLayout {
                    PriceButton(title: "Менее 5 000")
                    PriceButton(title: "5 000 - 12 000", isSelected: true)
                    PriceButton(title: "12 000 - 25 000")
                    PriceButton(title: "Более 25 000")
                    
                }
            }
        }
    }
}

#Preview {
    FilterPage()
}
