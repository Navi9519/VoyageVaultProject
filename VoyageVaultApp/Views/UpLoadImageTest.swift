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
        
        // Make sure that the selected image property isn't nil
        
        guard  selectedImage != nil  else {return}
        
        // Create storeage reference
        
        let storageRef = Storage.storage().reference()
        
        // Turn our image into data
        
        let imageData = selectedImage?.jpegData(compressionQuality: 0.8)
        
        
        // Check that we were able to convert it to data
        guard imageData !=  nil else {return}
        
        
        // Specify the file path and name
        
        
        let path = "images/\(UUID().uuidString).jpg"
        let fileRef = storageRef.child(path)
        
        
        
        // Upload that data
        
        
        let uploadTask = fileRef.putData(imageData!, metadata: nil) { metadata, error in
            
            // Check for errors
            
            if error == nil && metadata != nil {
                
                // Save a reference to the file in Firestore DB
                
                let db = firebase.db
                db.collection("images").document().setData(["url":path], completion: { error in
                    
                    // if there were no errors, diplay the new image
                    
                    if error == nil {
                        
                       // Add the uploaded image to the list of images for display
                        
                        DispatchQueue.main.async {
                            self.retrievedImages.append(self.selectedImage!)
                        }
                        
                        
                        
                        
                    }
                })
                    
                    
                    
                
                
            }
        }
        
        
        
        // Save a reference to the file in Firestore DB
    }
    
    
    func retrievePhotos() {
        
        // Get the data from the database
        
        let db = firebase.db
        
        
        db.collection("images").getDocuments { snapshot, error in
            
            if error == nil && snapshot != nil {
                
                var paths = [String]()
                
                // Loop through all the returned docs
                for doc in snapshot!.documents {
                    
                    // extract the file path and add to array
                    paths.append(doc["url"] as! String)
                    
                }
                
                // Loop through each file path and fetch the data from storage
                
                for path in paths {
                    
                    // get a reference to storage
                    
                    let storageRef = Storage.storage().reference()
                    
                    // Specify the path
                    
                    let fileRef = storageRef.child(path)
                    
                    
                    
                    // retrieve data
                    
                    fileRef.getData(maxSize: 5 * 1024 * 1024) { data, error in
                        
                        // Check for errors
                        
                        if error == nil && data != nil {
                            
                            // Create a UIImage and put it into our array for display
                            
                            if let image = UIImage(data: data!) {
                                
                                DispatchQueue.main.async {
                                    
                                    retrievedImages.append(image)
                                }
                                
                            }
                            
                        }
                    }
                    
                    //
                    
                }
                
                
            }
        }
        
        
        // Display the images
        
        
        
    }
}


#Preview {
    UpLoadImageTest(firebase: FirebaseAuth())
}
