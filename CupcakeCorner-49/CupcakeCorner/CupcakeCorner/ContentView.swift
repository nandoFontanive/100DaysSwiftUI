//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Fernando Fontanive on 17/01/24.
//
/*
 import SwiftUI
 
 struct Response: Codable {
 var results: [Result]
 }
 
 struct Result: Codable {
 var trackId: Int
 var trackName: String
 var collectionName: String
 }
 
 struct ContentView: View {
 @State private var results = [Result]()
 
 var body: some View {
 List(results, id: \.trackId) { item in
 VStack(alignment: .leading) {
 Text(item.trackName)
 .font(.headline)
 Text(item.collectionName)
 }
 }
 .task {
 await loadData()
 }
 }
 
 
 func loadData() async {
 guard let url = URL(string: "https://itunes.apple.com/search?term=jack+johnson&entity=song") else {
 print("Invalid URL")
 return
 }
 
 do {
 let (data, _) = try await URLSession.shared.data(from: url)
 
 if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data)
 {
 results = decodedResponse.results
 }
 } catch {
 print("Invalid data")
 }
 }
 }
 
 #Preview {
 ContentView()
 }
 */
/*
 import SwiftUI
 
 struct ContentView: View {
 @State private var username = ""
 @State private var email = ""
 
 var body: some View {
 Form {
 Section {
 TextField("Username", text: $username)
 TextField("Email", text: $email)
 }
 
 Section {
 Button("Create account") {
 print("Creating account…")
 }
 }
 .disabled(username.isEmpty || email.isEmpty)
 
 }
 }
 }
 */

