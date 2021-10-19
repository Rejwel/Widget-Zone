//
//  Widget_Zone_Widgets.swift
//  Widget Zone Widgets
//
//  Created by rey on 02/10/2021.
import WidgetKit
import SwiftUI

struct WidgetEntry: TimelineEntry {
    let date: Date = Date()
    let widget: MyWidget
}

struct Provider: TimelineProvider {
    
    @AppStorage("widgets", store: UserDefaults(suiteName: "group.rey.WidgetZoneApp"))
    var widgetData: Data = Data()
    
    init() {
        print(widgetData)
    }
    
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(widget: MyWidget(name: "Placeholder", description: "Description", color: "TestColor"))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        guard let widget = try? JSONDecoder().decode(MyWidget.self, from: widgetData) else { return }
        let entry = WidgetEntry(widget: widget)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        print("workstimeline")
        guard let widget = try? JSONDecoder().decode(MyWidget.self, from: widgetData) else { return }
        let entry = WidgetEntry(widget: widget)
        let timeline = Timeline(entries: [entry], policy: .after(.now))
        completion(timeline)
    }
}

struct WidgetEntryView: View {
    let entry: Provider.Entry
    
    var body: some View {
        VStack {
            Text(entry.widget.name)
                .padding()
            Text(entry.widget.description)
                .padding()
            Text(entry.widget.color)
                .padding()
        }
    }
}


@main
struct MyWidgetMain: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: "rey.Widget-Zone",
            provider: Provider()
        ) { entry in
            WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Your Widget")
        .description("This is your widget created in app")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
