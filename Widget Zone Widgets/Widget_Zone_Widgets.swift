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

// MARK: Provider

struct Provider: TimelineProvider {
    
    @AppStorage("widgets", store: UserDefaults(suiteName: "group.rey.WidgetZoneApp"))
    var widgetData: Data = Data()
    
    func placeholder(in context: Context) -> WidgetEntry {
        WidgetEntry(widget: MyWidget(name: "Placeholder", description: "Description", color: "TestColor"))
    }
    
    func getSnapshot(in context: Context, completion: @escaping (WidgetEntry) -> Void) {
        guard let widget = try? JSONDecoder().decode(MyWidget.self, from: widgetData) else { return }
        let entry = WidgetEntry(widget: widget)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<WidgetEntry>) -> Void) {
        guard let widget = try? JSONDecoder().decode(MyWidget.self, from: widgetData) else { return }
        let entry = WidgetEntry(widget: widget)
        let timeline = Timeline(entries: [entry], policy: .after(.now))
        completion(timeline)
    }
}

// MARK: Widget View

struct WidgetEntryView: View {
    
    // left up corner =
    // x 55 y 160 box 338 338
    // x -> width of screen - widget family medium size / 2
    // y -> height of screen -  2x medium + large / 3 ? test
    
    let entry: Provider.Entry
    
    
//    let image = cropImage(UIImage(imageLiteralResourceName: "test"), toRect: CGRect(x: 55, y: 160, width: 338, height: 338), viewWidth: UIScreen.main.nativeBounds.width, viewHeight: UIScreen.main.nativeBounds.height)
    
    // cropping for left bottom
    let image = cropImage(UIImage(imageLiteralResourceName: "test"), toRect: CGRect(x: ((UIScreen.main.bounds.width - mediumWidgetWidth())/2)*2.0, y: 160, width: 338, height: 338), viewWidth: UIScreen.main.nativeBounds.width, viewHeight: UIScreen.main.nativeBounds.height)
    
    
    var body: some View {
        ZStack {
            Image(uiImage: image!)
                .resizable()
                .scaledToFit()
            
                //.frame(width: 10, height: 10)
                
//            VStack {
//                Text(entry.widget.name)
//                    .padding()
//                Text(entry.widget.description)
//                    .padding()
//                Text(entry.widget.color)
//                    .padding()
//            }
        }
    }
}


// MARK: Functions
// func for cropping images
func cropImage(_ inputImage: UIImage, toRect cropRect: CGRect, viewWidth: CGFloat, viewHeight: CGFloat) -> UIImage? {
    let imageViewScale = max(inputImage.size.width / viewWidth,
                             inputImage.size.height / viewHeight)

    // Scale cropRect to handle images larger than shown-on-screen size
    let cropZone = CGRect(x:cropRect.origin.x * imageViewScale,
                          y:cropRect.origin.y * imageViewScale,
                          width:cropRect.size.width * imageViewScale,
                          height:cropRect.size.height * imageViewScale)

    // Perform cropping in Core Graphics
    guard let cutImageRef: CGImage = inputImage.cgImage?.cropping(to:cropZone)
    else {
        return nil
    }

    // Return image to UIImage
    let croppedImage: UIImage = UIImage(cgImage: cutImageRef)
    return croppedImage
}

func smallWidgetWidth() -> CGFloat {
        switch UIScreen.main.bounds.size {
        case CGSize(width: 428, height: 926): // 12 Pro Max
            return 170
        case CGSize(width: 414, height: 896):
            return 169
        case CGSize(width: 390, height: 844): // 12
            return 158
        case CGSize(width: 375, height: 812): // 12 Mini
            return 155
        case CGSize(width: 414, height: 736):
            return 159
        case CGSize(width: 375, height: 667):
            return 148
        case CGSize(width: 320, height: 568):
            return 141
        default:
            return 155
        }
    }
  
  func mediumWidgetWidth() -> CGFloat {
        switch UIScreen.main.bounds.size {
        case CGSize(width: 428, height: 926): // 12 Pro Max
            return 364
        case CGSize(width: 414, height: 896): // 11 Pro Max or 11
            return 360
        case CGSize(width: 390, height: 844): // 12
            return 338
        case CGSize(width: 375, height: 812): // 12 Mini or 11 Pro
            return 329
        case CGSize(width: 414, height: 736): // 8+
            return 348
        case CGSize(width: 375, height: 667): // 8
            return 321
        case CGSize(width: 320, height: 568): // SE
            return 292
        default:
            return 329
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
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                .background(.red)
        }
        .configurationDisplayName("Your Widget")
        .description("This is your widget created in app")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}
