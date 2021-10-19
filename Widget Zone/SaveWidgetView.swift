//
//  WidgetsView.swift
//  Widget Zone
//
//  Created by rey on 17/10/2021.
//

import SwiftUI
import WidgetKit

struct SaveWidgetView: View {
    
    let widget: MyWidget
    let completion: (MyWidget) -> Void
    
    var body: some View {
        Button {
            completion(widget)
            WidgetCenter.shared.reloadAllTimelines()
        } label: {
            Text(widget.name)
        }
        .frame(width: 120, height: 80, alignment: .center) 
    }
}
