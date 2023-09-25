//
//  ImageModelCacheManager.swift
//  RickyMorty
//
//  Created by Admin on 23/09/23.
//

import Foundation
import SwiftUI

class ImageModelCacheManager {
    static let instance = ImageModelCacheManager()
    
    private init() { }
    
    var imageCache: NSCache<NSString, UIImage> = {
       var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return  cache
    }()
    
    func add(key: String, value: UIImage){
        imageCache.setObject(value as UIImage, forKey: key as  NSString)
    }
    
    func get(key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
}
