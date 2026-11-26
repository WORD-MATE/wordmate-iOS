import SwiftUI

private enum ConsentKind: String, CaseIterable, Identifiable {
    case service = "서비스 이용약관"
    case privacy = "개인정보 수집·이용 동의"
    case marketing = "마케팅 정보 수신"

    var id: Self { self }
    var isRequired: Bool { self != .marketing }
}

struct SignupConsentView: View {
    @Environment(\.dismiss) private var dismiss
    @ScaledMetric(relativeTo: .title2) private var headingSize = 24.0
    @ScaledMetric(relativeTo: .body) private var rowTextSize = 16.0
    @State private var selectedConsents: Set<ConsentKind> = [.service, .privacy]
    @State private var showsNextStepNotice = false

    private let ink = Color(red: 18 / 255, green: 20 / 255, blue: 23 / 255)
    private let mutedInk = Color(red: 115 / 255, green: 122 / 255, blue: 131 / 255)
    private let lime = Color(red: 182 / 255, green: 224 / 255, blue: 42 / 255)
    private let card = Color(red: 248 / 255, green: 249 / 255, blue: 250 / 255)

    private var isAllSelected: Bool {
        selectedConsents.count == ConsentKind.allCases.count
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(alignment: .leading, spacing: 0) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .medium))
                        .frame(width: 44, height: 44, alignment: .leading)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .accessibilityLabel("뒤로")

                Text("한국님, 환영해요!\n약관에 동의해 주세요")
                    .font(.system(size: headingSize, weight: .heavy))
                    .tracking(-0.5)
                    .lineSpacing(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.top, 14)
                    .padding(.bottom, 30)
                    .accessibilityAddTraits(.isHeader)

                VStack(spacing: 8) {
                    Button(action: toggleAll) {
                        HStack(spacing: 12) {
                            ConsentMark(isSelected: isAllSelected, color: lime)
                            Text("전체 동의하기")
                                .font(.system(size: rowTextSize, weight: .bold))
                                .foregroundStyle(ink)
                            Spacer(minLength: 0)
                        }
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity, minHeight: 64)
                        .background(card, in: RoundedRectangle(cornerRadius: 8))
                        .contentShape(RoundedRectangle(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel("전체 동의하기")
                    .accessibilityValue(isAllSelected ? "선택됨" : "선택 안 됨")

                    VStack(spacing: 0) {
                        ForEach(ConsentKind.allCases) { kind in
                            consentRow(kind)
                        }
                    }
                }

                if showsNextStepNotice {
                    Text("다음 회원가입 단계는 아직 준비 중입니다.")
                        .font(.footnote)
                        .foregroundStyle(mutedInk)
                        .padding(.top, 12)
                        .accessibilityAddTraits(.updatesFrequently)
                }

                Spacer(minLength: 16)

                Button {
                    showsNextStepNotice = true
                } label: {
                    Text("동의하고 시작하기")
                        .font(.system(size: rowTextSize, weight: .bold))
                        .foregroundStyle(ink)
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(lime, in: RoundedRectangle(cornerRadius: 6))
                        .contentShape(RoundedRectangle(cornerRadius: 6))
                }
                .buttonStyle(.plain)
                .accessibilityHint("다음 회원가입 단계는 아직 연결되지 않았습니다.")
                .padding(.bottom, 8)
            }
            .padding(.horizontal, 24)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .frame(minHeight: geometry.size.height)
        }
        .foregroundStyle(ink)
        .background(Color.white.ignoresSafeArea())
        .toolbar(.hidden, for: .navigationBar)
        .preferredColorScheme(.light)
    }

    private func consentRow(_ kind: ConsentKind) -> some View {
        let isSelected = selectedConsents.contains(kind)
        return Button {
            toggle(kind)
        } label: {
            HStack(spacing: 12) {
                ConsentMark(isSelected: isSelected, color: lime)
                Text("\(kind.isRequired ? "[필수]" : "[선택]") \(kind.rawValue)")
                    .font(.system(size: rowTextSize, weight: .semibold))
                    .foregroundStyle(ink)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 4)
                Image(systemName: "chevron.right")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(mutedInk)
            }
            .padding(.horizontal, 8)
            .frame(maxWidth: .infinity, minHeight: 52)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(kind.isRequired ? "필수" : "선택") \(kind.rawValue)")
        .accessibilityValue(isSelected ? "동의함" : "동의 안 함")
        .accessibilityHint("두 번 탭하여 동의 여부를 변경합니다. 약관 상세 내용은 아직 제공되지 않습니다.")
    }

    private func toggleAll() {
        if isAllSelected {
            selectedConsents.removeAll()
        } else {
            selectedConsents = Set(ConsentKind.allCases)
        }
    }

    private func toggle(_ kind: ConsentKind) {
        if selectedConsents.contains(kind) {
            selectedConsents.remove(kind)
        } else {
            selectedConsents.insert(kind)
        }
    }
}

private struct ConsentMark: View {
    let isSelected: Bool
    let color: Color

    var body: some View {
        ZStack {
            Circle()
                .fill(isSelected ? color : .clear)
            Circle()
                .strokeBorder(isSelected ? color : Color(red: 196 / 255, green: 201 / 255, blue: 207 / 255), lineWidth: 1.5)
            if isSelected {
                Image(systemName: "checkmark")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundStyle(Color(red: 18 / 255, green: 20 / 255, blue: 23 / 255))
            }
        }
        .frame(width: 24, height: 24)
        .accessibilityHidden(true)
    }
}
