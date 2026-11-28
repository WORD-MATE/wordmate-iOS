import SwiftUI

struct StudentNotificationOverlay: View {
    let onAction: (String) -> Void

    private let items = StudentNotificationItem.sampleItems

    var body: some View {
        VStack(spacing: 0) {
            header

            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                StudentNotificationRow(item: item, onAction: onAction)

                if index < items.count - 1 {
                    Divider()
                        .padding(.leading, 66)
                }
            }
        }
        .background(Color.white, in: RoundedRectangle(cornerRadius: 10))
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(StudentMainPalette.card, lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.18), radius: 16, x: 0, y: 8)
        .accessibilityElement(children: .contain)
    }

    private var header: some View {
        HStack(spacing: 8) {
            Text("알림")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(StudentMainPalette.ink)

            Text("3")
                .font(.system(size: 10, weight: .bold))
                .foregroundStyle(StudentMainPalette.ink)
                .frame(minWidth: 18, minHeight: 18)
                .background(StudentMainPalette.lime, in: RoundedRectangle(cornerRadius: 4))
                .accessibilityLabel("읽지 않은 알림 3개")

            Spacer(minLength: 8)

            StudentMainNoticeButton(title: "모두 읽음", onAction: onAction) {
                Text("모두 읽음")
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(StudentMainPalette.muted)
                    .frame(minHeight: 44)
            }

            StudentMainNoticeButton(title: "알림 설정", onAction: onAction) {
                Image(systemName: "gearshape.fill")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(StudentMainPalette.ink)
                    .frame(width: 36, height: 44)
                    .contentShape(Rectangle())
            }
        }
        .padding(.leading, 16)
        .padding(.trailing, 10)
        .frame(height: 52)
        .overlay(alignment: .bottom) {
            Divider()
        }
    }
}
