//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Jon Mottram on 12/27/16.
//  Copyright © 2016 Jon Mottram. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController,
                      UITextFieldDelegate,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {
    //MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cancel: UIBarButtonItem!
    
    /*
     This value is either passed by 'MealTableViewController' in
      'prepare(for:sender:)'
     or constructed as part of adding a new meal.
     */
    var meal:Meal?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
        //  Enable the save button only if the text field has a valid Meal name
        updateSaveButtonState()
        
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //  Hide the keyboard (we're done with it)
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState( )
        navigationItem.title = textField.text
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField ) {
        //  Disable the save button while editing.
        saveButton.isEnabled = false
    }

    //MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //  Dismiss the picker if the user cancelled
        dismiss( animated: true, completion: nil )
    }

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        //  The info dictionary may contain multiple representations of the image.  We want the original
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as?
            UIImage else {
                fatalError( "Expected a dictionary containing an image, but got this : \(info)" )
        }
        
        //  Set the photo image now
        photoImageView.image = selectedImage
        
        //  Now that we've done that, we can dismiss the image picker
        dismiss( animated: true, completion: nil )
        
    }
    
    //MARK: Navigation
    
    //  This method lets you configure a view controller before it's presented
    override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare( for: segue, sender: sender )
        
        //  Configure the destination view controller only when the save button is pressed
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log( "The save button was not pressed, cancelling.", log: OSLog.default, type: .debug )
            return
        }
        let name = nameTextField.text ?? ""
        let photo = photoImageView.image
        let rating = ratingControl.rating
        
        //  Set the meal to be passed to MealTableViewController after the unwind segue
        meal = Meal( name: name, photo: photo, rating: rating )
    }
    //MARK: Actions
    
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //  Hide the keyboard (in case the user had that up when they hit the image)
        nameTextField.resignFirstResponder()
        
        //  UIImagePickerController is a view controller that allows the user to pick a media from their photo library.
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        
        //  Make sure view controller is notified when the user selects an image
        imagePickerController.delegate = self
        
        present( imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss( animated: true, completion: nil )
    }
    
    //MARK: Private Methods
    private func updateSaveButtonState( ) {
        //  Disable the save button if the text field is empty
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
        
    }
}

