//
//  ViewController.swift
//  MyContacts
//
//  Created by Samantha Thomas on 10/21/19.
//  Copyright © 2019 Samantha Thomas. All rights reserved.
//

import UIKit

//Updated from instructions.
import CoreData;

class ViewController: UIViewController
{
    //Outlets
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var birthdate: UITextField!
    
    //Actions
    @IBAction func btnSave(_ sender: UIButton)
    {
        //Copied from instructions.
        if (contactdb != nil)
        {
           
           contactdb.setValue(fullname.text, forKey: "fullname")
           contactdb.setValue(email.text, forKey: "email")
           contactdb.setValue(phone.text, forKey: "phone")
            contactdb.setValue(phone.text, forKey: "birthdate")
        }
        else
        {
           let entityDescription =
               NSEntityDescription.entity(forEntityName: "Contact",in: managedObjectContext)
           
           let contact = Contact(entity: entityDescription!,
                                 insertInto: managedObjectContext)
           
           contact.fullname = fullname.text!
           contact.email = email.text!
           contact.phone = phone.text!
            contact.birthdate = phone.text!
        }
        var error: NSError?
        do {
           try managedObjectContext.save()
        } catch let error1 as NSError {
           error = error1
        }
       
        if let err = error {
           //if error occurs
          // status.text = err.localizedFailureReason
        } else {
           self.dismiss(animated: false, completion: nil)
           
        }
    }
    
    @IBAction func btnEdit(_ sender: UIButton)
    {
        //Copied from instruction.
        fullname.isEnabled = true
        email.isEnabled = true
        phone.isEnabled = true
        birthdate.isEnabled = true
        btnSave.isHidden = false
        btnEdit.isHidden = true
        fullname.becomeFirstResponder()
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem)
    {
        //Copied from instructions.
        self.dismiss(animated: true, completion: nil)
        
        /*
        let detailVC = ContactTableViewController()
        detailVC.modalPresentationStyle = .fullScreen
        present(detailVC, animated: false)
        */
    }
    
    //Copied from assignment instructions.
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //Copied from assignment instructions.
    var contactdb:NSManagedObject!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Copied from assignment instructions.
        if (contactdb != nil)
        {
            fullname.text = contactdb.value(forKey: "fullname") as? String
            email.text = contactdb.value(forKey: "email") as? String
            phone.text = contactdb.value(forKey: "phone") as? String
            birthdate.text = contactdb.value(forKey: "birthdate") as? String
            btnSave.setTitle("Update", for: UIControl.State())
           
            btnEdit.isHidden = false
            fullname.isEnabled = false
            email.isEnabled = false
            phone.isEnabled = false
            birthdate.isEnabled = false
            btnSave.isHidden = true
        }else{
          
            btnEdit.isHidden = true
            fullname.isEnabled = true
            email.isEnabled = true
            phone.isEnabled = true
            birthdate.isEnabled = true
        }
        fullname.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
        //Looks for single or multiple taps
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
        
        //Adds tap gesture to view
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //Mine did not have this function so I added it from the assignment.
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Copied from instructions.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesBegan(touches , with:event)
        if (touches.first as UITouch?) != nil
        {
            DismissKeyboard()
        }
    }
    
    //Copied from instructions.
    @objc func DismissKeyboard()
    {
        //forces resign first responder and hides keyboard
        fullname.endEditing(true)
        email.endEditing(true)
        phone.endEditing(true)
        birthdate.endEditing(true)
    }
    
    //Copied from instructions.
    func textFieldShouldReturn(_ textField: UITextField!) -> Bool
    {
        textField.resignFirstResponder()
        return true;
    }

}

