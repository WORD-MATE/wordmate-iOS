import SwiftUI

struct StudentNotificationItem: Identifiable {
    let id: String
    let title: String
    let message: String
    let time: String
    let symbol: String
    let tint: Color

    static let sampleItems = [
        StudentNotificationItem(
            id: "battle-invitation",
            title: "대결 초대",
            message: "양지우님이 대결방에 초대했어요. 코드 K7Q2MX",
            time: "55분 전",
            symbol: "bolt.fill",
            tint: Color(red: 250 / 255, green: 191 / 255, blue: 66 / 255)
        ),
        StudentNotificationItem(
            id: "daily-sentence",
            title: "오늘의 문장",
            message: "Small habits, repeated every day...",
            time: "11시간 전",
            symbol: "sun.max.fill",
            tint: Color(red: 244 / 255, green: 153 / 255, blue: 50 / 255)
        ),
        StudentNotificationItem(
            id: "friend-request",
            title: "친구 요청",
            message: "욱골걸님이 친구 요청을 보냈어요.",
            time: "2시간 전",
            symbol: "person.2.fill",
            tint: Color(red: 75 / 255, green: 148 / 255, blue: 225 / 255)
        )
    ]
}

struct StudentNotificationRow: View {
    let item: StudentNotificationItem
    let onAction: (String) -> Void

    var body: some View {
        StudentMainNoticeButton(title: item.title, onAction: onAction) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName: item.symbol)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(item.tint)
                    .frame(width: 40, height: 40)
                    .background(StudentMainPalette.card, in: RoundedRectangle(cornerRadius: 8))
                    .accessibilityHidden(true)

                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 5) {
                        Text(item.title)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(StudentMainPalette.ink)
                            .lineLimit(1)

                        Circle()
                            .fill(Color(red: 242 / 255, green: 85 / 255, blue: 82 / 255))
                            .frame(width: 5, height: 5)
                            .accessibilityHidden(true)
                    }

                    Text(item.message)
                        .font(.system(size: 11, weight: .regular))
                        .foregroundStyle(StudentMainPalette.muted)
                        .lineLimit(1)
                        .truncationMode(.tail)

                    Text(item.time)
                        .font(.system(size: 10, weight: .regular))
                        .foregroundStyle(StudentMainPalette.muted)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Text("읽음")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundStyle(StudentMainPalette.muted)
                    .fixedSize()
            }
            .frame(maxWidth: .infinity, minHeight: 72, alignment: .center)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .contentShape(Rectangle())
        }
        .accessibilityHint("선택한 알림 기능은 아직 연결되지 않았습니다.")
    }
}
