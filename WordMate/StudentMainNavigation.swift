import SwiftUI

struct StudentMainBottomBar: View {
    let onAction: (String) -> Void

    var body: some View {
        HStack(spacing: 0) {
            tabItem("홈", icon: "house.fill", selected: true)
            tabItem("단어팩", icon: "square.grid.2x2", selected: false)
            tabItem("대결", icon: "person.2", selected: false)
            tabItem("랭킹", icon: "trophy", selected: false)
            tabItem("마이", icon: "person", selected: false)
        }
        .padding(.top, 8)
        .padding(.bottom, 4)
        .background(.white.shadow(.drop(color: .black.opacity(0.07), radius: 8, y: -2)))
    }

    private func tabItem(_ title: String, icon: String, selected: Bool) -> some View {
        StudentMainNoticeButton(title: title, onAction: onAction) {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: selected ? .semibold : .regular))
                Text(title)
                    .font(.system(size: 9, weight: selected ? .bold : .regular))
            }
            .foregroundStyle(selected ? StudentMainPalette.ink : StudentMainPalette.muted)
            .frame(maxWidth: .infinity, minHeight: 44)
            .contentShape(Rectangle())
        }
    }
}

struct StudentMainNoticeButton<Label: View>: View {
    let title: String
    let onAction: (String) -> Void
    @ViewBuilder let label: Label

    var body: some View {
        Button {
            onAction(title)
        } label: {
            label
        }
        .buttonStyle(.plain)
        .accessibilityLabel(title)
        .accessibilityHint("아직 연결되지 않은 기능에 대한 안내를 표시합니다.")
    }
}
