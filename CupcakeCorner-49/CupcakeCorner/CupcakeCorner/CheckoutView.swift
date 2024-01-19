//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Fernando Fontanive on 18/01/24.
//

import SwiftUI

struct CheckoutView: View {
    @State private var confirmationMessage = ""
    @State private var errorMessage = ""
    @State private var showingConfirmationMessage = false
    @State private var showingErrorMessage = false
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
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Thank you!", isPresented: $showingConfirmationMessage) {
            Button("OK") { }
        } message: {
            Text(confirmationMessage)
        }
        //If our call to placeOrder() fails – for example if there is no internet connection – show an informative alert for the user. To test this, try commenting out the request.httpMethod = "POST" line in your code, which should force the request to fail.

        .alert("Error!", isPresented: $showingErrorMessage) {
            Button("OK") { }
        } message: {
            Text(errorMessage)
        }
        }
    

        
    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order) else {
            print("Failed to encode order")
            return
        }
            let url = URL(string: "https://reqres.in/api/cupcakes")!
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST" //comment in order to force POST error

            do {
                let (data, _) = try await URLSession.shared.upload(for: request, from: encoded)
                let decoderOrder = try JSONDecoder().decode(Order.self, from: data)
                confirmationMessage = "Your order for \(decoderOrder.quantity)x \(Order.types[decoderOrder.type].lowercased()) cupcakes is on the way!"
                showingConfirmationMessage = true
            } catch {
                print("Checkout failed: \(error.localizedDescription)")
                errorMessage = "Deu ruim :("
                showingErrorMessage = true
            }
        }
    }
    
    


#Preview {
    CheckoutView(order: Order())
}
