//
//  PageIndicator.swift
//  ViewTest2
//
//  Created by Lex on 2020/2/9.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

struct PageDots: View {
    internal init(
        currentIndex: Binding<Int>,
        pageCount: Int
    ) {
        self._currentIndex = currentIndex
        self.pageCount = pageCount
    }
    
    @Binding var currentIndex: Int
    let pageCount: Int
    
    var body: some View {
        HStack(spacing: 9.0) {
            ForEach(0..<pageCount) { page in
                PageIndicatorCircle(currentPageIndex: self.$currentIndex, page: page)
            }
        }
        .frame(height: 20)
    }
}

struct PageIndicator_Previews: PreviewProvider {
    static var previews: some View {
        PageDots(currentIndex: .constant(1), pageCount: 3)
    }
}

struct PageIndicatorCircle: View {
    @Binding var currentPageIndex: Int
    let page: Int
    
    var body: some View {
        Circle()
            .frame(width: 7, height: 7)
            .foregroundColor(page == currentPageIndex ? Color.primary : Color.secondary)
            .scaleEffect(page == currentPageIndex ? 1.25 : 1)
            .animation(.easeInOut(duration: 0.25))
    }
}
