//
//  PageView.swift
//  ViewTest2
//
//  Created by Lex on 2020/2/9.
//  Copyright © 2020 Lex. All rights reserved.
//

import SwiftUI

struct PageView<Content: View>: View {
    @Binding var currentIndex: Int
    @GestureState private var translation: CGFloat = 0
    let pageCount: Int
    let swipeEnabled: Bool
    let showPageDots: Bool
    let pageDotsAlignment: HorizontalAlignment
    let content: Content
    
    init(
        pageCount: Int,
        currentIndex: Binding<Int>,
        swipeEnabled: Bool = true,
        showPageDots: Bool = false,
        pageDotsAlignment: HorizontalAlignment = .center,
        @ViewBuilder content: () -> Content
    ) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.swipeEnabled = swipeEnabled
        self.showPageDots = showPageDots
        self.pageDotsAlignment = pageDotsAlignment
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                self.content
                    .frame(width: geometry.size.width, alignment: .leading)
                    .offset(x: -CGFloat(self.currentIndex) * geometry.size.width)
                    .offset(x: self.translation)
                    .animation(.easeInOut(duration: 0.25))
                    .gesture(
                        DragGesture()
                            .updating(self.$translation) { (value, state, _) in
                                guard self.swipeEnabled else { return }
                                if value.translation.width < 0 {
                                    guard self.currentIndex != self.pageCount - 1 else { return }
                                }
                                if value.translation.width > 0 {
                                    guard self.currentIndex != 0 else { return }
                                }
                                state = value.translation.width
                        }
                        .onEnded { (value) in
                            guard self.swipeEnabled else { return }
                            if value.predictedEndTranslation.width > geometry.size.width / 2 {
                                self.currentIndex = max(self.currentIndex - 1, 0)
                            }
                            if value.predictedEndTranslation.width < geometry.size.width / 2 {
                                self.currentIndex = min(self.currentIndex + 1, self.pageCount - 1)
                            }
                        }
                )
                
                PageDots(currentIndex: self.$currentIndex, pageCount: self.pageCount)
                    .opacity(self.showPageDots ? 1 : 0)
                    .frame(maxWidth: .infinity, alignment: Alignment(horizontal: self.pageDotsAlignment, vertical: .bottom))
                    .padding(.horizontal, UIApplication.shared.windows.filter{$0.isKeyWindow}.first?.safeAreaInsets.left)
            }
        }
    }
}
