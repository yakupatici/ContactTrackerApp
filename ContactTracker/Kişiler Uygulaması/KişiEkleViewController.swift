//
//  KişiEkleViewController.swift
//  Kişiler Uygulaması
//
//  Created by Jacob on 19.08.2023.
//

import UIKit

class Kis_iEkleViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext

    @IBOutlet weak var kisiAdTextField: UITextField!
    
    
    @IBOutlet weak var mobileNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    

    @IBAction func addButton(_ sender: Any) {
        
        let kisi = Kisiler(context: context)
        
        if let  namee = kisiAdTextField.text , let mobileNumberr = mobileNumberTextField.text{
            let kisi = Kisiler(context: context)
            kisi.kisi_name = namee
            kisi.kisi_number = mobileNumberr
            
            appDelegate.saveContext()
        }
    }
    

}
