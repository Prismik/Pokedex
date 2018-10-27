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
        self.image = nil
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }
        Http.request(url: url) { (response) in
            switch response {
            case .success(let data):
                guard let data = data as? Data, let image = UIImage(data: data) else { return }
                imageCache.setObject(image, forKey: NSString(string: urlString))
                self.image = image
            case .failure:
                self.image = placeholder
            }
        }
    }
}
