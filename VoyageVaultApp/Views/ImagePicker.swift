//
//  ImagePicker.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-30.
//

import Foundation
import UIKit
import SwiftUI


struct ImagePicker: UIViewControllerRepresentable {
    
    
    @Binding var selectedImage: UIImage?
    @Binding var isPickerShowing: Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
       
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator // Object that can recieve UIImagePickerController events
        
        return imagePicker
    }
    
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        
        return Coordinator(self)
    }
    
}



class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var parent: ImagePicker
    
    init(_ picker: ImagePicker) {
        
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
       
        // Run code when the user as selected an image
        
        print("image selected")
        
       if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            // We were able to get the image
            
           DispatchQueue.main.async {
               
               self.parent.selectedImage = image
               
           }
           
        }
        
        // Dismiss the picker
        
        parent.isPickerShowing = false
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        // Run code when the user has cancelled the picker UI
        
        parent.isPickerShowing = false 
        
        print("cancelled")
    }
    
    
   
    
    
}
