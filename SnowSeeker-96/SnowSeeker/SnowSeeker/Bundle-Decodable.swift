//
//  Bundle-Decodable.swift
//  SnowSeeker
//
//  Created by Fernando Fontanive on 29/10/24.
//

import Foundation

extension Bundle {
    func decode<someKindOfType: Decodable>(_ file: String) -> someKindOfType {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in the bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to read \(file) from the bundle.")
        }
        
        let decoder = JSONDecoder()
        
        do {
            return try decoder.decode(someKindOfType.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key in '\(key)' - \(context.debugDescription).")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch - \(context.debugDescription).")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value  - \(context.debugDescription).")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON.")
        } catch {
            fatalError("Failed to decode \(file) from bundle due to error: \(error.localizedDescription).")
        }
        
    }
}
