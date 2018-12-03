//
//  UIImageView+async.swift
//  Pokedex
//
//  Created by Francis Beauchamp on 2018-10-27.
//  Copyright © 2018 Francis Beauchamp. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(from urlString: String, placeholder: UIImage? = nil) {
        let formatedString = urlString.replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "/", with: ".")
        self.image = nil
        // Try to load from cache
        if let cachedImage = imageCache.object(forKey: NSString(string: formatedString)) {
            self.image = cachedImage
            return
        }

        // Try to load from disk
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = documentsDirectory.appendingPathComponent(formatedString)
        if FileManager.default.fileExists(atPath: fileURL.path) {
            self.image = UIImage(contentsOfFile: fileURL.path)
            guard let image = self.image else { return }
            imageCache.setObject(image, forKey: NSString(string: formatedString))
        } else {
            // Load from server
            guard let url = URL(string: urlString) else { return }
            Http.request(url: url) { (response) in
                switch response {
                case .success(let data):
                    guard let data = data as? Data, let image = UIImage(data: data) else { return }
                    imageCache.setObject(image, forKey: NSString(string: formatedString))
                    self.image = image
                    do {
                        try UIImagePNGRepresentation(image)?.write(to: fileURL, options: .atomic)
                    } catch {
                        print("Error writing file to disk")
                    }
                case .failure:
                    self.image = placeholder
                }
            }
        }
    }
}
