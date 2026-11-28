import SwiftUI

struct StudentMainLearningSections: View {
    let onAction: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            todayTasks
            continueLearning
            dailySentence
            dailyMissions
            ranking
        }
    }

    private var todayTasks: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle("오늘 할 일")
            HStack(spacing: 10) {
                taskCard(title: "오늘의 복습", count: "12", icon: "arrow.clockwise", tint: Color(red: 76 / 255, green: 142 / 255, blue: 216 / 255))
                taskCard(title: "오답노트", count: "7", icon: "xmark.circle", tint: Color(red: 236 / 255, green: 93 / 255, blue: 101 / 255))
            }
        }
    }

    private var continueLearning: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                sectionTitle("이어서 학습")
                Spacer()
                StudentMainNoticeButton(title: "전체 단어팩", onAction: onAction) {
                    HStack(spacing: 4) {
                        Text("전체 단어팩")
                            .font(.system(size: 11, weight: .medium))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 9, weight: .semibold))
                    }
                    .foregroundStyle(StudentMainPalette.muted)
                }
            }

            StudentMainNoticeButton(title: "수능 필수 영단어 Day 12", onAction: onAction) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("수능 필수 영단어 Day 12")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(StudentMainPalette.ink)
                            Text("기본 단어팩 · 4지선다 · 영-한 · 12분부터")
                                .font(.system(size: 10, weight: .regular))
                                .foregroundStyle(StudentMainPalette.muted)
                        }
                        Spacer(minLength: 4)
                        Image(systemName: "chevron.right")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundStyle(StudentMainPalette.muted)
                    }

                    HStack(spacing: 8) {
                        ProgressView(value: 14, total: 24)
                            .tint(StudentMainPalette.lime)
                        Text("14 / 24")
                            .font(.system(size: 10, weight: .medium))
                            .foregroundStyle(StudentMainPalette.muted)
                    }
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(StudentMainPalette.card, in: RoundedRectangle(cornerRadius: 8))
            }
        }
    }

    private var dailySentence: some View {
        StudentMainNoticeButton(title: "오늘의 문장 퀴즈", onAction: onAction) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("오늘의 문장 · 11월 8일")
                        .font(.system(size: 10, weight: .regular))
                        .foregroundStyle(StudentMainPalette.muted)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(StudentMainPalette.muted)
                }
                Text("Small habits, repeated every day, quietly shape who we become.")
                    .font(.system(size: 14, weight: .heavy))
                    .tracking(-0.2)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(StudentMainPalette.ink)
                HStack {
                    Spacer()
                    Text("퀴즈 풀기  ›")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundStyle(StudentMainPalette.ink)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(StudentMainPalette.lime, in: RoundedRectangle(cornerRadius: 5))
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(StudentMainPalette.card, in: RoundedRectangle(cornerRadius: 8))
        }
    }

    private var dailyMissions: some View {
        VStack(alignment: .leading, spacing: 12) {
            sectionTitle("일일 미션")
            VStack(spacing: 0) {
                missionRow(title: "대결 1회 참여", progress: "1/1", reward: "+15 XP 받기", isComplete: true)
                Divider().padding(.leading, 34)
                missionRow(title: "단어 20개 학습", progress: "14/20", reward: "+20 XP", isComplete: false)
                Divider().padding(.leading, 34)
                missionRow(title: "오늘의 문장 퀴즈", progress: "0/1", reward: "+10 XP", isComplete: false)
            }
            .padding(.horizontal, 12)
            .background(StudentMainPalette.card, in: RoundedRectangle(cornerRadius: 8))
        }
    }

    private var ranking: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .firstTextBaseline) {
                HStack(spacing: 6) {
                    sectionTitle("23위")
                    Text("▲ 5")
                        .font(.system(size: 10, weight: .bold))
                        .foregroundStyle(Color(red: 75 / 255, green: 143 / 255, blue: 220 / 255))
                }
                Spacer()
                StudentMainNoticeButton(title: "전체 랭킹", onAction: onAction) {
                    HStack(spacing: 4) {
                        Text("전체 랭킹")
                            .font(.system(size: 10, weight: .medium))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 9, weight: .semibold))
                    }
                    .foregroundStyle(StudentMainPalette.muted)
                }
            }

            VStack(spacing: 2) {
                rankingRow(place: "22", name: "양지윤", xp: "450 XP", change: "+38", isCurrentUser: false)
                rankingRow(place: "23", name: "나", xp: "412 XP", change: "", isCurrentUser: true)
                rankingRow(place: "24", name: "양지우", xp: "401 XP", change: "−11", isCurrentUser: false)
            }
            .padding(8)
            .background(StudentMainPalette.card, in: RoundedRectangle(cornerRadius: 8))
        }
    }

    private func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 16, weight: .heavy))
            .tracking(-0.3)
            .accessibilityAddTraits(.isHeader)
    }

    private func taskCard(title: String, count: String, icon: String, tint: Color) -> some View {
        StudentMainNoticeButton(title: title, onAction: onAction) {
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(tint)
                        .frame(width: 28, height: 28)
                        .background(tint.opacity(0.12), in: RoundedRectangle(cornerRadius: 6))
                        .accessibilityHidden(true)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.system(size: 10, weight: .medium))
                        .foregroundStyle(StudentMainPalette.muted)
                }
                Text(title)
                    .font(.system(size: 9, weight: .medium))
                    .foregroundStyle(StudentMainPalette.muted)
                Text("\(count) 단어")
                    .font(.system(size: 14, weight: .heavy))
            }
            .frame(maxWidth: .infinity, minHeight: 90, alignment: .leading)
            .padding(12)
            .background(StudentMainPalette.card, in: RoundedRectangle(cornerRadius: 8))
        }
    }

    private func missionRow(title: String, progress: String, reward: String, isComplete: Bool) -> some View {
        StudentMainNoticeButton(title: title, onAction: onAction) {
            HStack(spacing: 8) {
                Image(systemName: isComplete ? "checkmark.circle.fill" : "circle")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(isComplete ? StudentMainPalette.lime : Color(red: 195 / 255, green: 200 / 255, blue: 207 / 255))
                    .frame(width: 20)
                    .accessibilityHidden(true)
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(StudentMainPalette.ink)
                    if !isComplete {
                        ProgressView(value: progressValue(for: progress), total: progressTotal(for: progress))
                            .tint(StudentMainPalette.lime)
                    }
                }
                Spacer(minLength: 4)
                Text(reward)
                    .font(.system(size: 9, weight: .medium))
                    .foregroundStyle(StudentMainPalette.muted)
                    .lineLimit(1)
            }
            .frame(minHeight: 42)
            .contentShape(Rectangle())
        }
    }

    private func rankingRow(place: String, name: String, xp: String, change: String, isCurrentUser: Bool) -> some View {
        StudentMainNoticeButton(title: "랭킹 \(place)위 \(name)", onAction: onAction) {
            HStack(spacing: 8) {
                Text(place)
                    .font(.system(size: 10, weight: .semibold))
                    .frame(width: 20)
                Image(systemName: "person.fill")
                    .font(.system(size: 9, weight: .medium))
                    .foregroundStyle(StudentMainPalette.muted)
                    .frame(width: 20, height: 20)
                    .background(Color(red: 232 / 255, green: 235 / 255, blue: 239 / 255), in: Circle())
                    .accessibilityHidden(true)
                Text(name)
                    .font(.system(size: 10, weight: isCurrentUser ? .bold : .medium))
                    .foregroundStyle(StudentMainPalette.ink)
                Spacer()
                Text(xp)
                    .font(.system(size: 10, weight: .semibold))
                if !change.isEmpty {
                    Text(change)
                        .font(.system(size: 9, weight: .medium))
                        .foregroundStyle(StudentMainPalette.muted)
                }
            }
            .padding(.horizontal, 8)
            .frame(height: 30)
            .background(isCurrentUser ? Color(red: 232 / 255, green: 234 / 255, blue: 237 / 255) : .clear, in: RoundedRectangle(cornerRadius: 5))
            .contentShape(Rectangle())
        }
    }

    private func progressValue(for progress: String) -> Double {
        Double(progress.split(separator: "/").first ?? "0") ?? 0
    }

    private func progressTotal(for progress: String) -> Double {
        Double(progress.split(separator: "/").last ?? "1") ?? 1
    }
}
