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



//import PhotosUI
//import SwiftUI
//
//struct ContentView: View {
//    @State private var pickerItems = [PhotosPickerItem]()
//    @State private var selectedImages = [Image]()
//    
//    var body: some View {
//        VStack {
//            PhotosPicker(selection: $pickerItems, maxSelectionCount: 5, matching: .any(of: [.images, .not(.screenshots)])) {
//                Label("Select", systemImage: "photo")
//            }
//            ScrollView {
//                ForEach(0..<selectedImages.count, id:\.self) { i in
//                    selectedImages[i]
//                        .resizable()
//                        .scaledToFit()
//                }
//            }
//        }
//        .onChange(of: pickerItems) {
//            Task {
//                selectedImages.removeAll()
//                for item in pickerItems {
//                    if let loadedImage = try await item.loadTransferable(type: Image.self) {
//                        selectedImages.append(loadedImage)
//                    }
//                }
//            }
//        }
//    }
//}

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    @State private var processedImage: Image?
    @State private var filterIntensity = 0.5
    @State private var radiusIntensity = 100.0
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                PhotosPicker(selection: $selectedItem) {
                    if let processedImage {
                        processedImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                HStack {
                    Text("Intensity")
                    //Try making the Slider and Change Filter buttons disabled if there is no image selected.
                    if processedImage != nil {
                        Slider(value: $filterIntensity)
                            .disabled(false)
                    }
                    else {
                        Slider(value: $filterIntensity)
                            .disabled(true)
                    }
                    Text("Radius")
                    if processedImage != nil {
                        Slider(value: $radiusIntensity)
                            .disabled(false)
                    }
                    else {
                        Slider(value: $radiusIntensity)
                            .disabled(true)
                    }
                }
                .onChange(of: filterIntensity, applyProcessing)
                HStack {
                    Button("Change filter", action: changeFilter)
                    Spacer()
                    
                    if let processedImage {
                        ShareLink(item: processedImage, preview: SharePreview("Instafilter image", image: processedImage))
                    }
                    
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters) {
                Button("Crystallize") { setFilter(CIFilter.crystallize() )}
                Button("Edges") { setFilter(CIFilter.edges() )}
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur() )}
                Button("Pixellate") { setFilter(CIFilter.pixellate() )}
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone() )}
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask() )}
                Button("Vignette") { setFilter(CIFilter.vignette() )}
                Button("Cancel", role: .cancel) { }
            }
        }
    }
    func changeFilter() {
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else { return }
            guard let inputImage = UIImage(data: imageData) else { return }
            
            let beginImage = CIImage(image: inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcessing()
            
        }
    }
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
//        currentFilter.intensity = Float(filterIntensity)
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radiusIntensity * 200, forKey: kCIInputRadiusKey) }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }
    
        guard let outputImage = currentFilter.outputImage else { return }
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
    
        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }

    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()

        filterCount += 1
        if filterCount >= 2 {
            requestReview()
        }
    }
}
#Preview {
    ContentView()
}
