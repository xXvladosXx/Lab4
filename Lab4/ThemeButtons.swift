import SwiftUI

struct ThemeButtonView: View {
    let themeName: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: isSelected ? "circle.fill" : "circle")
                    .foregroundColor(isSelected ? .blue : .gray)
                    .font(.system(size: 50))
                Text(themeName)
                    .font(.caption)
            }
        }
    }
}
