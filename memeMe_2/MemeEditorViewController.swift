//
//  MemeEditorViewController.swift
//  memeMe_2
//
//  Created by Anna Rogers on 7/7/16.
//  Copyright © 2016 Anna Rogers. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topToolbar: UINavigationBar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    
    //    name the delegates
    let topTextDelegate = TextFieldDelegate()
    let bottomTextDelegate = TextFieldDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        shareButton.enabled = false
        formatText("Top")
        formatText("Bottom")
    }
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    func formatText (textPosition: String) {
        let selector = textPosition == "Top" ? topText : bottomText
        _ = textPosition == "Top" ? topTextDelegate : bottomTextDelegate
        selector.text = textPosition
        selector.defaultTextAttributes = memeTextAttributes
        selector.textAlignment = .Center
        selector.delegate = topTextDelegate
    }
    
//    Deal with showing the text area for the bottom text when editing
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications () {
//        NSNotification center
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications () {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
//else to deal with if the user clicks straight from the bottom text to the top text(not leave a keyboard gap)
    func keyboardWillShow(notification: NSNotification) {
        if bottomText.isFirstResponder() {
            view.frame.origin.y = getKeyboardHeight(notification) * (-1)
        } else if topText.isFirstResponder(){
            reset()
        }
    }
    
//  return the keyboard to the bottom position
    func reset() {
        self.view.frame.origin.y = 0
    }
    
    func keyboardWillHide(notification: NSNotification) {
        reset()
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
//    go to the album or the camera depending on what was clicked
    
    @IBAction func pickMemeMethod(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if sender.tag == 3 {
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        } else if sender.tag == 4 {
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        }
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageView.contentMode = UIViewContentMode.ScaleAspectFit
            shareButton.enabled = true
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
//    save the image to the array in the app delegate so it can then be accessed in the table and collection views
    func save(memedImage: UIImage) {
        let meme = Meme(topString: topText.text!, bottomString: bottomText.text!, originalImage: imageView.image!, memedImage: memedImage)
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    @IBAction func shareMemeButtonPressed(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity: String?, completed: Bool, items: [AnyObject]?, error: NSError?) -> Void in
            if completed {
                self.save(memedImage)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    func generateMemedImage() -> UIImage {
        topToolbar.hidden = true
        bottomToolbar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        topToolbar.hidden = false
        bottomToolbar.hidden = false
        return memedImage
    }
    
//    return to the meme views
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
 
    
}
