//
//  ContentView.swift
//  HotProspects
//
//  Created by Fernando Fontanive on 11/10/24.
//

import SwiftUI
import SamplePackage

struct ContentView: View {
    var body: some View {
        TabView {
            ProspectsView(filter: .none)
                .tabItem {
                    Label("Everyone", systemImage: "person.3")
                }
            
            ProspectsView(filter: .contacted)
                .tabItem {
                    Label("Contact", systemImage: "checkmark.circle")
                }
            
            ProspectsView(filter: .uncontacted)
                .tabItem {
                    Label("Uncontacted", systemImage: "questionmark.diamond")
                }
            
            MeView()
                .tabItem {
                    Label("Me", systemImage: "person.crop.square")
                }
        }
    }
}

#Preview {
    ContentView()
}


//    day 81
//    let possibleNumbers = 1...60
//
//    var results: String {
//        let selected = possibleNumbers.random(7).sorted()
//        let stringsRandomized = selected.map(String.init)
//        return stringsRandomized.formatted()
//    }
//
//    var body: some View {
//        Text(results)
// day 81 notification
//        VStack {
//            Button("Request permission") {
//                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
//                    if success {
//                        print("all ok!")
//
//                    }
//                    else if let error {
//                        print(error.localizedDescription)
//                    }
//
//                }
//            }
//            Button("Schedule notification") {
//                let contentTrigger = UNMutableNotificationContent()
//                contentTrigger.title = "Feed the cat"
//                contentTrigger.subtitle = "Poor kitty"
//                contentTrigger.sound = UNNotificationSound.default
//
//                let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
//
//                let requestTrigger = UNNotificationRequest(identifier: UUID().uuidString, content: contentTrigger, trigger: notificationTrigger)
//
//                UNUserNotificationCenter.current().add(requestTrigger)
//            }
//        }
// day 81
//        List {
//            Text("Taylor")
//                .swipeActions {
//                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
//                        print("Delete")
//                    }
//                }
//                .swipeActions(edge: .leading) {
//                    Button("Pin", systemImage: "pin") {
//                        print("Pinning")
//                    }
//                    .tint(.orange)
//                }
//
//        }
//        day 81
//        Text("Hellot!")
//            .padding()
//            .background(backGroundColor)
//        Text("Change background color")
//            .padding()
//            .background(.red)
//            .contextMenu {
//                Button("red", systemImage: "paperplane.fill", role: .destructive) {
//                    backGroundColor = .red
//                }
//                Button("blue", systemImage: "checkmark.circle") {
//                    backGroundColor = .blue
//                }
//                Button("gray") {
//                    backGroundColor = .gray
//                }
//            }
    //        day 80 - result
    //        Text(output)
    //            .task {
    //                await fetchReadings()
    //            }
    //
    //    }
    //
    //    func fetchReadings() async {
    //        let fetchTask = Task {
    //            let url = URL(string: "https://hws.dev/readings.json")!
    //            let (data, _) = try await URLSession.shared.data(from: url)
    //            let readings = try JSONDecoder().decode([Double].self, from: data)
    //            return "Found \(readings.count) readings"
    //        }
    //        let resultado = await fetchTask.result
    //        switch resultado {
    //            case .success(let str):
    //                output = str
    //            case .failure(let error):
    //                output = "Error: \(error.localizedDescription)"
    //        }
    //
    ////        do {
    ////            output = try resultado.get()
    ////        } catch {
    ////            output = "Error: \(error.localizedDescription)"
    ////        }
    //
    //
    //    }
//day 79
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            Button("Show Tab 2") {
//                selectedTab = "dois"
//            }
//            .tabItem {
//                Label("One", systemImage: "star")
//            }
//            .tag("um")
//
//            Text("Tab 2")
//                .tabItem {
//                    Label("Two", systemImage: "globe")
//                }
//                .tag("dois")
//
//        }
//
//    }
