import Charts
import SwiftUI

struct AnalyticsDashboardView: View {
    let repository: Repository

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                SectionHeader(title: "Analytics", subtitle: "Commit frequency, churn, contributors, and language mix")

                HStack(spacing: 12) {
                    MetricTile(title: "Weekly Commits", value: "\(repository.weeklyActivity.reduce(0) { $0 + $1.commits })", systemImage: "calendar")
                    MetricTile(title: "Additions", value: "+\(repository.weeklyActivity.reduce(0) { $0 + $1.additions })", systemImage: "plus.square")
                    MetricTile(title: "Deletions", value: "-\(repository.weeklyActivity.reduce(0) { $0 + $1.deletions })", systemImage: "minus.square")
                }

                AnalyticsPanel(title: "Commit Frequency") {
                    Chart(repository.weeklyActivity) { week in
                        AreaMark(
                            x: .value("Week", week.weekStart),
                            y: .value("Commits", week.commits)
                        )
                        .foregroundStyle(.blue.opacity(0.22))

                        LineMark(
                            x: .value("Week", week.weekStart),
                            y: .value("Commits", week.commits)
                        )
                        .foregroundStyle(.blue)
                        .interpolationMethod(.catmullRom)
                    }
                    .chartXAxis(.hidden)
                    .frame(height: 220)
                }

                AnalyticsPanel(title: "Code Churn") {
                    Chart(repository.weeklyActivity) { week in
                        BarMark(
                            x: .value("Week", week.weekStart),
                            y: .value("Additions", week.additions)
                        )
                        .foregroundStyle(.green.opacity(0.75))

                        BarMark(
                            x: .value("Week", week.weekStart),
                            y: .value("Deletions", -week.deletions)
                        )
                        .foregroundStyle(.red.opacity(0.75))
                    }
                    .chartXAxis(.hidden)
                    .frame(height: 220)
                }

                AnalyticsPanel(title: "Language Breakdown") {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(repository.languageBreakdown) { language in
                            HStack {
                                Circle()
                                    .fill(language.color)
                                    .frame(width: 10, height: 10)
                                Text(language.name)
                                Spacer()
                                Text(language.percentage.formatted(.number.precision(.fractionLength(0))) + "%")
                                    .foregroundStyle(.secondary)
                            }
                            ProgressView(value: language.percentage, total: 100)
                                .tint(language.color)
                        }
                    }
                }

                AnalyticsPanel(title: "Contribution Heatmap") {
                    ContributionHeatmap(activity: repository.weeklyActivity)
                }
            }
            .padding(GlassHubTheme.contentSpacing)
        }
    }
}

private struct AnalyticsPanel<Content: View>: View {
    let title: String
    @ViewBuilder var content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            content
        }
        .padding()
        .background(.quaternary.opacity(0.5), in: RoundedRectangle(cornerRadius: GlassHubTheme.compactRadius))
    }
}

private struct ContributionHeatmap: View {
    let activity: [WeeklyActivity]
    private let columns = Array(repeating: GridItem(.fixed(16), spacing: 5), count: 12)

    var body: some View {
        LazyVGrid(columns: columns, alignment: .leading, spacing: 5) {
            ForEach(activity) { week in
                RoundedRectangle(cornerRadius: 3)
                    .fill(color(for: week.commits))
                    .frame(width: 16, height: 16)
                    .help("\(week.commits) commits")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private func color(for commits: Int) -> Color {
        switch commits {
        case 0: .gray.opacity(0.18)
        case 1...5: .green.opacity(0.25)
        case 6...10: .green.opacity(0.45)
        case 11...15: .green.opacity(0.7)
        default: .green
        }
    }
}
