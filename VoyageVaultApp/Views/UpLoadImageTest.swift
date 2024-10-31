//
//  UpLoadImageTest.swift
//  VoyageVaultApp
//
//  Created by Ivan Dedic on 2024-10-30.
//

import Foundation
import SwiftUI
import FirebaseStorage
import FirebaseFirestore



struct UpLoadImageTest: View {
    
    
    @State var isPickerShowing = false
    @State var selectedImage: UIImage?
    @State var retrievedImages = [UIImage]()
    
    @ObservedObject var firebase: FirebaseAuth
    
    var body: some View {
        
        VStack {
            
            if selectedImage != nil {
                
                Image(uiImage: selectedImage!).resizable().frame(width: 200, height: 200)
                
            }
            
            
            Button(action: {
                
                isPickerShowing = true
                
            }, label: {
                
                Text("Select a photo")
            })
            
            if selectedImage != nil {
                
                Button(action: {
                    
                    // Upload the image
                    
                    uploadFoto()
                    
                }, label: {
                    
                    Text("Upload photo")
                })
                
            }
            
            
            Divider()
            
            HStack {
                
                // Loop through the images and display them
                ForEach(retrievedImages, id: \.self) { image in
                    
                    Image(uiImage: image).resizable().frame(width: 100, height: 100)
                    
                    
                }
            }
            
            
        }.sheet(isPresented: $isPickerShowing, onDismiss: nil) {
            
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing)
            
        }
        .onAppear {
            retrievePhotos()
        }
        
        
    }
    
    
    
    func uploadFoto() {
        
        // Ensure there's a selected image
        guard let selectedImage = selectedImage else {return}
        
        // Get the current user's ID
        guard let userId = firebase.auth.currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        
        // Create storeage reference
        let storageRef = Storage.storage().reference()
        
        
        // Convert the image to data
        guard let imageData = selectedImage.jpegData(compressionQuality: 0.8) else {return}
        
        // Specify the file path and name
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        
        // Upload that data
        let uploadTask = fileRef.putData(imageData, metadata: nil) { metadata, error in
            // Check for errors
            if error == nil && metadata != nil {
                
                // Get the download URL
                fileRef.downloadURL { url, error in
                    if let downloadURL = url {
                        // now save the URL to Firestore in the user's document
                        let db = firebase.db
                        db.collection("user_data").document(userId).updateData(["images": FieldValue.arrayUnion([downloadURL.absoluteString])]) { error in
                            if let error = error {
                                print("Error updating images array: \(error.localizedDescription)")
                            } else {
                                DispatchQueue.main.async {
                                    self.retrievedImages.append(selectedImage) // Append to your retrived images for display
                                }
                            }
                        }
                    }
                }
            } else {
                print("Error uploading photo: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    
    func retrievePhotos() {
        
        // Get the current user's ID
        guard let userId = firebase.auth.currentUser?.uid else {
            print("User not logged in")
            return
        }
        
        // Get the data from the database
        let db = firebase.db
        
        // Get the user's document
        
        db.collection("user_data").document(userId).getDocument { document, error in
            if let document = document, document.exists {
                // Retrive the image array
                if let imageArray = document.data()?["images"] as? [String] {
                    var paths = [String]()
                    
                    // Loop through each URL and fetch the data
                    for url in imageArray {
                        paths.append(url)
                        
                        //Retrive data from storage using the URL
                        let storageRef = Storage.storage().reference(forURL: url)
                        storageRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                            if let error = error {
                                print("Error retreving image data: \(error.localizedDescription)")
                                return
                            }
                            if let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    retrievedImages.append(image) // add the retrived image to the array
                                }
                            }
                        }
                        
                    }
                    
                }
            } else {
                print("Document does not exist or error occurred : \(error?.localizedDescription ?? "Unkown error")")
            }
        }
    }
    
}
    #Preview {
        UpLoadImageTest(firebase: FirebaseAuth())
    }
    

