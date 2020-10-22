//
//  MyWidget.swift
//  MyWidget
//
//  Created by Hanlin Chen on 10/22/20.
//

import WidgetKit
import SwiftUI


struct DataEntry: TimelineEntry {
    var date: Date
    var time: String
}


struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> DataEntry {
        return DataEntry(date: Date(), time: "Loading...")
    }
    
    typealias Entry = DataEntry
    
    func getSnapshot(in context: Context, completion: @escaping (Entry) -> Void) {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat  = "hh:mm:ss a"
        let time = formatter.string(from: date)
        
        let entry = DataEntry(date: date, time: time)
        
        completion(entry)
    }
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
     
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat  = "hh:mm:ss a"
        
        
        var entries:[DataEntry] = []
        for offset in 0...5  {
        let updateDate = Calendar.current.date(byAdding: .second, value: offset, to: date)!
        let time = formatter.string(from: updateDate)
        let entry = DataEntry(date: updateDate, time: time)
        entries.append(entry)
        }
        let timeLine = Timeline(entries: entries, policy: .atEnd)
        print("update")
        completion(timeLine)
    }
}


struct WidgetView: View {
    var data: Provider.Entry
    @Environment(\.widgetFamily) var family
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text("Time").font(family == .systemSmall ? .body : (family == .systemMedium ? .title : .largeTitle))
                Spacer()
            }.padding().background(Color.yellow)
            
            Spacer()
            Text(data.time).foregroundColor(.white).padding(.horizontal, 20)
            Spacer()
        }.background(Color.black)
    }
}


@main
struct WidgetConfig: Widget {
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "mywidget", provider: Provider(), content: {
            entry in
            WidgetView(data: entry)
        }).supportedFamilies([.systemSmall, .systemMedium])
        .description(Text("Current Time Widget"))
    }
    
    
}




