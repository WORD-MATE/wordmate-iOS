import SwiftUI

struct StudentLoginView: View {
    @ScaledMetric(relativeTo: .title2) private var sloganSize = 24.0
    @ScaledMetric(relativeTo: .body) private var buttonLabelSize = 16.0
    @State private var showsLoginAvailability = false

    private let ink = Color(red: 21 / 255, green: 22 / 255, blue: 26 / 255)
    private let lime = Color(red: 182 / 255, green: 227 / 255, blue: 35 / 255)
    private let buttonFill = Color(red: 239 / 255, green: 240 / 255, blue: 242 / 255)

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(verbatim: "wordmate")
                        .font(.system(size: 27, weight: .semibold))
                        .tracking(-0.8)
                        .accessibilityLabel("워드메이트")
                        .accessibilityAddTraits(.isHeader)

                    Spacer(minLength: 24)
                    hero
                    Spacer(minLength: 24)
                    footer
                }
                .padding(.horizontal, 24)
                .padding(.top, 12)
                .padding(.bottom, max(8, 24 - geometry.safeAreaInsets.bottom))
                .frame(minHeight: geometry.size.height)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
        .foregroundStyle(ink)
        .background(Color.white.ignoresSafeArea())
        .preferredColorScheme(.light)
    }

    private var hero: some View {
        Text(verbatim: "mate")
            .font(.system(size: 120, weight: .black))
            .tracking(-3)
            .lineLimit(1)
            .minimumScaleFactor(0.65)
            .scaleEffect(x: 1.16, y: 1.20, anchor: .leading)
            .frame(width: 246, height: 104, alignment: .leading)
            .background(alignment: .bottomLeading) {
                Rectangle()
                    .fill(lime)
                    .frame(height: 21)
                    .padding(.bottom, 24)
            }
            .offset(y: -20)
            .accessibilityHidden(true)
    }

    private var footer: some View {
        VStack(alignment: .leading, spacing: 20) {
            ViewThatFits(in: .horizontal) {
                VStack(alignment: .leading, spacing: 3) {
                    Text("매일 10분,")
                    HStack(spacing: 0) {
                        Text("단어로 ")
                        Text("겨루고")
                            .background(alignment: .bottom) {
                                Rectangle()
                                    .fill(lime)
                                    .frame(height: sloganSize * 0.48)
                            }
                        Text(" 성장하기")
                    }
                }
                .fixedSize(horizontal: true, vertical: false)

                Text("매일 10분,\n단어로 겨루고 성장하기")
                    .fixedSize(horizontal: false, vertical: true)
            }
            .font(.system(size: sloganSize, weight: .heavy))
            .tracking(-0.6)
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("매일 10분, 단어로 겨루고 성장하기")

            VStack(alignment: .leading, spacing: 8) {
                Button {
                    showsLoginAvailability = true
                } label: {
                    HStack(spacing: 8) {
                        DataGSMMark()
                            .fill(ink, style: FillStyle(eoFill: true))
                            .frame(width: 16, height: 16)
                            .accessibilityHidden(true)

                        Text("DataGSM으로 로그인")
                            .font(.system(size: buttonLabelSize, weight: .bold))
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity, minHeight: 56)
                    .background(buttonFill, in: RoundedRectangle(cornerRadius: 6))
                    .contentShape(RoundedRectangle(cornerRadius: 6))
                }
                .buttonStyle(.plain)
                .accessibilityHint("아직 연결되지 않은 로그인 기능을 안내합니다.")

                if showsLoginAvailability {
                    Text("DataGSM 로그인은 아직 연결되지 않았습니다.")
                        .font(.footnote)
                        .onAppear {
                            AccessibilityNotification.Announcement(
                                "DataGSM 로그인은 아직 연결되지 않았습니다."
                            ).post()
                        }
                }
            }
        }
    }
}

private struct DataGSMMark: Shape {
    func path(in rect: CGRect) -> Path {
        let scale = CGAffineTransform(scaleX: rect.width / 16, y: rect.height / 16)
        var mark = Path()
        mark.addLines([
            CGPoint(x: 0, y: 0),
            CGPoint(x: 9, y: 0), CGPoint(x: 9, y: 2), CGPoint(x: 12, y: 2),
            CGPoint(x: 12, y: 4), CGPoint(x: 14, y: 4), CGPoint(x: 14, y: 6),
            CGPoint(x: 16, y: 6), CGPoint(x: 16, y: 11), CGPoint(x: 14, y: 11),
            CGPoint(x: 14, y: 13), CGPoint(x: 12, y: 13), CGPoint(x: 12, y: 15),
            CGPoint(x: 9, y: 15), CGPoint(x: 9, y: 16), CGPoint(x: 0, y: 16)
        ])
        mark.closeSubpath()
        mark.addLines([
            CGPoint(x: 4, y: 3),
            CGPoint(x: 9, y: 3), CGPoint(x: 9, y: 5), CGPoint(x: 11, y: 5),
            CGPoint(x: 11, y: 11), CGPoint(x: 9, y: 11), CGPoint(x: 9, y: 13),
            CGPoint(x: 4, y: 13)
        ])
        mark.closeSubpath()
        return mark.applying(scale)
    }
}
