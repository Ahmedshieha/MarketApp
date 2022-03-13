//
//  ViewController.swift
//  MarketApp
//
//  Created by MacBook on 22/12/2021.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemViewController: UIViewController {
    var category:Category?
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var gallery : GalleryController!
    let hud = JGProgressHUD(style: .dark)
    var activityIndicator : NVActivityIndicatorView?
    var itemImges : [UIImage?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addPhotoButton.layer.cornerRadius = 10
        hud.textLabel.text =  "Loading"
        hud.show(in: self.view)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30  , y: self.view.frame.height / 2 - 30 , width: 50, height: 50), type: .lineSpinFadeLoader, color: .lightGray, padding: nil)
        
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
        showLoadingIndicator()
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text!
        item.categoryId = category?.id
        item.price = Double(priceTextField.text!.replacedArabicDigitsWithEnglish)
        
        if itemImges.count > 0 {
            uploadImages(images: itemImges, itemId: item.id) {imageLinks in
                
                item.imageLinks = imageLinks
                print(imageLinks)
                saveItemToFirebase(item: item)
                self.popView()
                self.hideLoadingIndicator()
            }
            
        }
        else {
            
            saveItemToFirebase(item: item)
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
    
    
    func showLoadingIndicator () {
        
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator?.startAnimating()
        }
    }
    
    func hideLoadingIndicator() {
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
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



