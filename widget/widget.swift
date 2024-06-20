//
//  widget.swift
//  widget
//
//  Created by kai on 2024/06/18.
//

import WidgetKit
import SwiftUI
//import FirebaseFirestoreSwift

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

//    var body: some View {
//            VStack{
//                ForEach(entry.items){ item in
//                    Text(item.title)
//                }
//                }
//            }
//    

struct widgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        switch widgetFamily {
        case .accessoryCircular:
            // ロック画面用のビュー
            ZStack {
                VStack {
                    Text("叶")
                        .font(.title)
                }
                .padding()
            }
            .widgetAccentable()
            .background(
                Circle()
                    .fill(Color.black)
            )
        case .systemSmall:
            // 小サイズのビュー
            VStack {
                Text("今日のタスク")
                Text(entry.configuration.favoriteEmoji)
            }
            .padding()
        case .systemMedium:
            // 中サイズのビュー
            VStack {
                Text("今日のタスクを確認しよう！！")
                Text(entry.configuration.favoriteEmoji)
            }
            .padding()
        case .systemLarge:
            // 大サイズのビュー
            VStack {
                Text("今日のタスク")
                    .font(.title)
                Text("詳細なタスクの説明")
                Text(entry.configuration.favoriteEmoji)
                    .font(.largeTitle)
            }
            .padding()
        case .systemExtraLarge:
            // 特大サイズのビュー
            VStack {
                Text("今日のタスク")
                    .font(.title)
                Text("詳細なタスクの説明")
                    .font(.body)
                Text(entry.configuration.favoriteEmoji)
                    .font(.system(size: 80))
            }
            .padding()
        case .accessoryRectangular:
            VStack {
                Text("今日のタスク")
                    .font(.title)
                Text("詳細なタスクの説明")
                    .font(.body)
                Text(entry.configuration.favoriteEmoji)
                    .font(.system(size: 80))
            }
            .padding()
        case .accessoryInline:
            VStack {
                Text("今日のタスク")
                    .font(.title)
                Text("詳細なタスクの説明")
                    .font(.body)
                Text(entry.configuration.favoriteEmoji)
                    .font(.system(size: 80))
            }
            .padding()
        @unknown default:
            fatalError("Unknown WidgetFamily")
        }
    }
}
struct widget: Widget {
    let kind: String = "widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            widgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies(supportedFamilies)
    }
    
    @available(iOSApplicationExtension 16.0, *)
        private var supportedFamilies: [WidgetFamily] {
            [
                .systemSmall,
                .systemMedium,
                .systemLarge,
                .systemExtraLarge,
                .accessoryInline,
                .accessoryCircular,
                .accessoryRectangular
            ]
        }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
