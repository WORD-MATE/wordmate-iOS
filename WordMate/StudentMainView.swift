import SwiftUI

struct StudentMainView: View {
    @State private var noticeTitle = ""
    @State private var showsNotice = false
    @State private var showsNotifications = false

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 0) {
                header

                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        welcomeCard
                        summaryCards
                        StudentMainLearningSections(onAction: showNotice)
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 20)
                }
                .scrollIndicators(.hidden)

                StudentMainBottomBar(onAction: showNotice)
            }

            if showsNotifications {
                StudentNotificationOverlay(onAction: showNotice)
                    .padding(.horizontal, 20)
                    .padding(.top, 52)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    .zIndex(1)
            }
        }
        .foregroundStyle(StudentMainPalette.ink)
        .background(Color.white.ignoresSafeArea())
        .preferredColorScheme(.light)
        .alert(noticeTitle, isPresented: $showsNotice) {
            Button("확인", role: .cancel) { }
        } message: {
            Text("이 기능은 아직 연결되지 않았어요.")
        }
    }

    private var header: some View {
        HStack {
            Text("wordmate")
                .font(.system(size: 22, weight: .bold))
                .tracking(-0.7)
                .accessibilityLabel("워드메이트")
                .accessibilityAddTraits(.isHeader)

            Spacer()

            Button {
                withAnimation(.easeInOut(duration: 0.2)) {
                    showsNotifications.toggle()
                }
            } label: {
                Image(systemName: "bell.badge.fill")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(StudentMainPalette.muted)
                    .frame(width: 44, height: 44)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityLabel("알림")
            .accessibilityValue(showsNotifications ? "열림" : "닫힘")
            .accessibilityHint("알림 오버레이를 표시하거나 닫습니다.")
        }
        .padding(.horizontal, 20)
        .frame(height: 52)
        .background(.white)
    }

    private var welcomeCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("한국님, 오늘도\n단어 10개만 해볼까요?")
                .font(.system(size: 20, weight: .heavy))
                .tracking(-0.5)
                .fixedSize(horizontal: false, vertical: true)
                .accessibilityAddTraits(.isHeader)

            HStack(spacing: 8) {
                StudentMainNoticeButton(title: "학습하기", onAction: showNotice) {
                    actionLabel("학습하기", prominent: true)
                }
                StudentMainNoticeButton(title: "대결하기", onAction: showNotice) {
                    actionLabel("대결하기", prominent: false)
                }
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            LinearGradient(
                colors: [StudentMainPalette.heroStart, StudentMainPalette.heroEnd],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ),
            in: RoundedRectangle(cornerRadius: 10)
        )
    }

    private var summaryCards: some View {
        HStack(spacing: 8) {
            summaryCard(title: "연속 학습", value: "7", suffix: "일", icon: "flame.fill", color: Color(red: 245 / 255, green: 96 / 255, blue: 72 / 255))
            summaryCard(title: "실버", value: "Lv.12", suffix: "", icon: "chart.bar.fill", color: Color(red: 85 / 255, green: 179 / 255, blue: 158 / 255))
            summaryCard(title: "오늘 XP", value: "86", suffix: "/500", icon: "sparkles", color: Color(red: 244 / 255, green: 184 / 255, blue: 54 / 255))
        }
    }

    private func summaryCard(title: String, value: String, suffix: String, icon: String, color: Color) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundStyle(color)
                    .accessibilityHidden(true)
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                    .foregroundStyle(StudentMainPalette.muted)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
            }
            HStack(alignment: .firstTextBaseline, spacing: 2) {
                Text(value)
                    .font(.system(size: 17, weight: .heavy))
                    .tracking(-0.4)
                if !suffix.isEmpty {
                    Text(suffix)
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(StudentMainPalette.muted)
                }
            }
            if title == "오늘 XP" {
                ProgressView(value: 86, total: 500)
                    .tint(StudentMainPalette.lime)
            } else if title == "실버" {
                Capsule().fill(StudentMainPalette.lime).frame(width: 40, height: 3)
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 76, alignment: .leading)
        .background(StudentMainPalette.card, in: RoundedRectangle(cornerRadius: 8))
        .accessibilityElement(children: .combine)
    }

    private func actionLabel(_ title: String, prominent: Bool) -> some View {
        HStack(spacing: 8) {
            Spacer(minLength: 0)
            Text(title)
                .font(.system(size: 12, weight: .bold))
            Image(systemName: "chevron.right")
                .font(.system(size: 9, weight: .bold))
            Spacer(minLength: 0)
        }
        .foregroundStyle(prominent ? Color.white : StudentMainPalette.ink)
        .frame(maxWidth: .infinity, minHeight: 44)
        .background(prominent ? StudentMainPalette.ink : Color.white.opacity(0.55), in: RoundedRectangle(cornerRadius: 7))
    }

    private func showNotice(_ title: String) {
        noticeTitle = title
        showsNotice = true
    }
}

enum StudentMainPalette {
    static let ink = Color(red: 20 / 255, green: 22 / 255, blue: 26 / 255)
    static let muted = Color(red: 111 / 255, green: 118 / 255, blue: 128 / 255)
    static let lime = Color(red: 184 / 255, green: 228 / 255, blue: 36 / 255)
    static let card = Color(red: 247 / 255, green: 248 / 255, blue: 250 / 255)
    static let heroStart = Color(red: 184 / 255, green: 231 / 255, blue: 38 / 255)
    static let heroEnd = Color(red: 82 / 255, green: 220 / 255, blue: 188 / 255)
}

#Preview {
    StudentMainView()
}

#Preview("알림 오버레이") {
    ZStack(alignment: .top) {
        StudentMainView()

        StudentNotificationOverlay(onAction: { _ in })
            .padding(.horizontal, 20)
            .padding(.top, 52)
    }
}
