//
//  ImagePicker.swift
//  COLOMBO-BSCCOMP-PT-202-013
//
//  Created by Mohamed Fazil on 2022-04-17.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImages: [UIImage]?
    @Binding var isPickerShowing: Bool
    var limit: Int = 1
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = limit
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.selectedImages = []
            let dispatchGroup = DispatchGroup()
            for result in results {
                dispatchGroup.enter()
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { image, _ in
                        self.parent.selectedImages?.append(image as! UIImage)
                        dispatchGroup.leave()
                    }
                } else {
                    print("Image Picker Error")
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.parent.isPickerShowing = false
            }
        }
    }
}


