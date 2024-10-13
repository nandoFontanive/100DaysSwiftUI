//
//  ContentView.swift
//  HotProspects
//
//  Created by Fernando Fontanive on 11/10/24.
//

import SwiftUI

struct ContentView: View {
    @State private var backGroundColor = Color.yellow
    
    var body: some View {
        List {
            Text("Taylor")
                .swipeActions {
                    Button("Delete", systemImage: "minus.circle", role: .destructive) {
                        print("Delete")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button("Pin", systemImage: "pin") {
                        print("Pinning")
                    }
                    .tint(.orange)
                }
                
        }
    
    }
}
#Preview {
    ContentView()
}
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
