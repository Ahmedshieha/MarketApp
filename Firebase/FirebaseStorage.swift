//
//  FirebaseStorage.swift
//  MarketApp
//
//  Created by MacBook on 03/01/2022.
//

import Foundation
import FirebaseStorage
import UIKit

let storage = Storage.storage()

func uploadImages (images : [UIImage?], itemId : String , completionHandler : @escaping(_ imageLinks : [String] ) ->Void ) {
    
    if Reachabilty.HasConnection() {
        
        var uploadImagesCount = 0
        var imageLinkArray : [String] = []
        var nameSuffix = 0
        
        for image in images {
            let fileName = "ItemImages/" + itemId + "/" + "\(nameSuffix)" + ".jpg"
            let imageData = image!.jpegData(compressionQuality: 0.01)
            
            saveImagesToFirebase(imageData: imageData!, fileName: fileName) { (imageLink) in
                if imageLink != nil {
                    imageLinkArray.append(imageLink!)
                    uploadImagesCount += 1
                    
                    if uploadImagesCount == images.count {
                        completionHandler(imageLinkArray)
                        
                    }
                }
               
            }
            
            nameSuffix += 1
            
        }
        
        
    }
    
    else {
        print("no internet connection")
    }
    
    
    
}

func saveImagesToFirebase(imageData : Data , fileName : String , completionHandler : @escaping (_ imageLink : String?) -> Void ){
    
    var task : StorageUploadTask!
    let storageRef = storage.reference(forURL: fileRefrence).child(fileName)
    task = storageRef.putData(imageData,metadata: nil,completion: { (metaData, error) in
        
        task.removeAllObservers()
        if error != nil  {
            print(error?.localizedDescription ?? "" )
            completionHandler(nil)
            
            
        }
        storageRef.downloadURL { url, error in
            guard let downloadUrl = url else {
                completionHandler(nil)
                return
            }
            completionHandler(downloadUrl.absoluteString)
        }
    })
}

func downloadImages  (imageLinks : [String] , completionHandler : @escaping (_ images : [UIImage])-> Void ) {
    
    var imageArray : [UIImage] = []
    var imagesLinkCount  =   0
    
    for link  in imageLinks {
        let url = NSURL(string: link)
        let downloadQueue = DispatchQueue(label: "imageDownloadQueue")
        
        downloadQueue.async {
            imagesLinkCount  += 1
            let data =  NSData(contentsOf: url! as URL)
            
            if data !=  nil {
                imageArray.append(UIImage(data: data! as Data)!)
                if imagesLinkCount ==  imageArray.count {
                    DispatchQueue.main.async {
                        completionHandler(imageArray)
                    }
                }
            }  else {
                print("couldent Download Image ")
            }
            
        }
        
    }
    
}


