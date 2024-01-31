//
//  ContentView.swift
//  Instafilter
//
//  Created by Fernando Fontanive on 29/01/24.
//
//
//import CoreImage
//import CoreImage.CIFilterBuiltins
//import SwiftUI
//
//struct ContentView: View {
//    @State private var image: Image?
//
//    var body: some View {
//        VStack {
//            image?
//                .resizable()
//                .scaledToFill()
//        }
//        .onAppear(perform: loadImage)
//    }
//
//    func loadImage() {
//        let inputImage = UIImage(resource: .example)
//        let beginImage = CIImage(image: inputImage)
//
//        let context = CIContext()
//        let currentFilter = CIFilter.crystallize()
//        currentFilter.inputImage = beginImage
//
//        let amount = 1.0
//
//        let inputKeys = currentFilter.inputKeys
//
//        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(amount, forKey: kCIInputIntensityKey) }
//        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(amount * 200, forKey: kCIInputRadiusKey) }
//        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(amount * 10, forKey: kCIInputScaleKey) }
//
//
//
//        guard let outputImage = currentFilter.outputImage else { return }
//        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
//
//        let uiImage = UIImage(cgImage: cgImage)
//        image = Image(uiImage: uiImage)
//    }
//}
//
//#Preview {
//    ContentView()
//}



import PhotosUI
import SwiftUI

struct ContentView: View {
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $pickerItems, maxSelectionCount: 5, matching: .any(of: [.images, .not(.screenshots)])) {
                Label("Select", systemImage: "photo")
            }
            ScrollView {
                ForEach(0..<selectedImages.count, id:\.self) { i in
                    selectedImages[i]
                        .resizable()
                        .scaledToFit()
                }
            }
        }
        .onChange(of: pickerItems) {
            Task {
                selectedImages.removeAll()
                for item in pickerItems {
                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
                        selectedImages.append(loadedImage)
                    }
                }
            }
        }
    }
}
