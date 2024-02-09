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
    }
}
