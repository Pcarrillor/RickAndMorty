//
//  ImageModelFileManager.swift
//  RickyMorty
//
//  Created by Admin on 23/09/23.
//

import Foundation

import Foundation
import SwiftUI

class ImageModelFileManager {
    static let instance = ImageModelFileManager()
    let folderName = "downloaded_images"
    
    private init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        
        if FileManager.default.fileExists(atPath: url.path) {
            do{
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
                debugPrint("Created Folder")
            } catch let error {
                debugPrint("Error creating folder. \(error)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathExtension(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else {
            return nil
        }
        return  folder.appendingPathComponent(key + ".jpeg")
    }
    
    func add(key: String, value: UIImage){
        guard
            let data = value.jpegData(compressionQuality: 1.0),
            let url =  getImagePath(key: key) else { return }
        
        do {
            try data.write(to: url)
        } catch let error {
            debugPrint("Error saving to file manager. \(error)")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path()) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path())
    }
}
