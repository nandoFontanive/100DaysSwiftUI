//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Fernando Fontanive on 07/02/24.
//

import CoreLocation
import Foundation
import LocalAuthentication
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        var locations = [Location]()
        var selectedPlace: Location?
        var isUnlocked = false
        
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        
        
            init() {
                do {
                    let data = try Data(contentsOf: savePath)
                    locations = try JSONDecoder().decode([Location].self, from: data)
                } catch {
                    locations = []
                }
            }
            func save() {
                do {
                    let data = try JSONEncoder().encode(locations)
                    try data.write(to: savePath, options: [.atomic, .completeFileProtection])
                } catch {
                    print("Unable to save data.")
                }
            }
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitute: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }
        
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = location.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?

            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."

                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                    }
                }
            } else {
                // no biometrics
            }
        }

        
        
        if viewModel.isUnlocked {
        } else {
            Button("Unlock Places", action: viewModel.authenticate)
                .padding()
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(.capsule)
            
        }
    }
    
    
    
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                
                if success {
                    self.isUnlocked = true
                } else {
                    // error
                }
            }
        } else {
            // no biometrics
        }
    }
    
}
