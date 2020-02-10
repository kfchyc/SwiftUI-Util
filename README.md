# SwiftUI-Util
some utils of SwiftUI View and functions used frequently in my own projects.

## PageView
- Example:
```swift
struct ContentView: View {
    @State var currentIndex = 0
    
    var body: some View {
        PageView(
        pageCount: 3,
        currentIndex: self.$currentIndex,
        swipeEnabled: true,
        showPageDots: true,
        pageDotsAlignment: .trailing
        ) {
            HStack(spacing: 0.0) {
                Color.orange
                    .frame(width: UIScreen.main.bounds.width)
                Color.blue
                    .frame(width: UIScreen.main.bounds.width)
                Color.pink
                    .frame(width: UIScreen.main.bounds.width)
            }
            .edgesIgnoringSafeArea(.all)
        }
    }
}
```
> ⚠️Attension: You must set content views in a single container like HStack and all contentView should has its own fixed size so the ScrollView in PageView can show content usually.
