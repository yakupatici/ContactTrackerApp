//
//  KişiGüncelleViewController.swift
//  Kişiler Uygulaması
//
//  Created by Jacob on 19.08.2023.
//

import UIKit

class Kis_iGu_ncelleViewController: UIViewController {
    let context = appDelegate.persistentContainer.viewContext
    var kisi : Kisiler?

    @IBOutlet weak var MobileNumberTextField: UITextField!
    @IBOutlet weak var KisiAdTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()


        if let k = kisi {
            KisiAdTextField.text = k.kisi_name
            MobileNumberTextField.text = k.kisi_number
            
        }    }
    

    @IBAction func updateContacts(_ sender: Any) {
        if let k = kisi,let ad = KisiAdTextField.text,let tel = MobileNumberTextField.text{
            k.kisi_name = ad
            k.kisi_number = tel
            
       
            
            appDelegate.saveContext()
        }
        
    }
    

}
