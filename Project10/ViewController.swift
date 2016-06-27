//
//  ViewController.swift
//  Project10
//
//  Created by Sachin Lamba on 27/06/16.
//  Copyright © 2016 LambaG. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var people = [Person]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: #selector(addNewPerson))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return people.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Person", forIndexPath: indexPath) as! PersonCell
        
        let person = people[indexPath.item]
        
        cell.name.text = person.name
        
        let path = getDocumentsDirectory().stringByAppendingPathComponent(person.image)
        
        cell.imageView.image = UIImage(contentsOfFile: path)
        
        
        
        return cell
    }

    func addNewPerson() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        let imageName = NSUUID().UUIDString
        let imagePath = getDocumentsDirectory().stringByAppendingPathComponent(imageName)

        if let jpegData = UIImageJPEGRepresentation(newImage, 80) {
            jpegData.writeToFile(imagePath, atomically: true)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        people.append(person)
        collectionView.reloadData()
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        
        return documentsDirectory
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let person = people[indexPath.item]
        
        let ac = UIAlertController(title: "Rename Person", message: nil, preferredStyle: .Alert)
        
        ac.addTextFieldWithConfigurationHandler(nil)
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        ac.addAction(UIAlertAction(title: "OK", style: .Default) { [unowned self, ac] _ in
            let newName = ac.textFields![0]
            if (newName.text! != "") {
                person.name = newName.text!
            }
            self.collectionView.reloadData()
        })
        
        presentViewController(ac, animated: true, completion: nil)
    }
    
    
    
}

