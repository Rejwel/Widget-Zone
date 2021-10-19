//
//  ContentView.swift
//  Widget Zone
//
//  Created by rey on 02/10/2021.
//

import SwiftUI
import WidgetKit

struct ContentView: View {
    
    @AppStorage("widgets", store: UserDefaults(suiteName: "group.rey.WidgetZoneApp"))
    var widgetData: Data = Data()
    
    let widgets = [
        MyWidget(name: "Test widget", description: "Test widget description", color: "red"),
        MyWidget(name: "Test widget2", description: "Test widget description2", color: "green"),
        MyWidget(name: "Test widget3", description: "Test widget description3", color: "blue")
    ]
    
    var body: some View {
        ForEach(widgets) { widget in
            SaveWidgetView(widget: widget, completion: { widget in
                saveWidget(widget: widget)
            })
        }
    }
    
    func saveWidget(widget: MyWidget) {
        guard let data = try? JSONEncoder().encode(widget) else { return }
        self.widgetData = data
    }
}
