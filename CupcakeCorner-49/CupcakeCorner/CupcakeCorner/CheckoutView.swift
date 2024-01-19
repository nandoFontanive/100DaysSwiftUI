//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Fernando Fontanive on 18/01/24.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var showingConfirmationMessage = false
    var order: Order
    
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)
                
                Text("Your total is \(order.cost, format: .currency(code: "USD"))")
                    .font(.title)
                
                Button("Place Order") {
                    Task {
                        await placeOrder()
                    }
                }
                    .padding()
                }
            }
        .navigationTitle("Check out")
        .alert("Thank you!", isPresented: $showingConfirmationMessage) {
            Button("OK") { }
        } message: {
        Text(confirmationMessage)
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)

        }
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"

            do {
                let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
                let decoderOrder = try JSONDecoder().decode(Order.self, from: data)
                confirmationMessage = "Your order for \(decoderOrder.quantity)x \(Order.types[decoderOrder.type].lowercased()) cupcakes is on the way!"
                showingConfirmationMessage = true
            } catch {
                print("Checkout failed: \(error.localizedDescription)")
            }
        }
    }
    
    


#Preview {
    CheckoutView(order: Order())
}
