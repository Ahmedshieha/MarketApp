//
//  ViewController.swift
//  MarketApp
//
//  Created by MacBook on 22/12/2021.
//

import UIKit
import Gallery
import JGProgressHUD


class AddItemViewController: UIViewController {
    var category:Category?
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var gallery : GalleryController!
    let hud = JGProgressHUD(style: .dark)
  
    var itemImges : [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addPhotoButton.layer.cornerRadius = 10
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hud.textLabel.text = "Loading"
    }
    
    
    @IBAction func addPhotoButton(_ sender: Any) {
        itemImges = []
        showGallery()
        
    }
    
    
    @IBAction func doneButton(_ sender: Any) {
        if fieldsAreCompleted() {
            dismissKeyboard()
            saveItem ()
        }else {
            let alert = UIAlertController(title: "Error", message: " all fields are required ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    @IBAction func backGroundTapped(_ sender: Any) {
        dismissKeyboard()
    }
    
    private func dismissKeyboard() {
        self.view.endEditing(false)
    }
    
    private func fieldsAreCompleted () -> Bool {
        return (titleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "")
    }
    func saveItem() {
        hud.show(in: self.view)
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text!
        item.description = descriptionTextView.text
        item.categoryId = category?.id
        item.price = Double(priceTextField.text!.replacedArabicDigitsWithEnglish)
        if itemImges.count > 0 {
            uploadImages(images: itemImges, itemId: item.id) {imageLinks in
                
                item.imageLinks = imageLinks
                saveItemToFirebase(item: item)
//                saveItemToAlgolia(item: item)
                self.popView()
                self.hud.dismiss()
            }
            
        }
        else {
            
            saveItemToFirebase(item: item)
            saveItemToAlgolia(item: item)
            popView()
            
        }
        
        
    }
    private func popView(){
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func showGallery () {
        self.gallery = GalleryController()
        self.gallery.delegate = self
        Config.tabsToShow = [.imageTab , .cameraTab]
        Config.Camera.imageLimit = 6
        self.present(self.gallery, animated: true, completion: nil)
    }
    

}
extension AddItemViewController : GalleryControllerDelegate {
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        if images.count > 0 {
            Image.resolve(images: images) { (resolvedImages) in
                self.itemImges = resolvedImages
            }
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    
}



