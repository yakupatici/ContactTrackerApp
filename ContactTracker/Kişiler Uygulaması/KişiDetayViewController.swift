//
//  KişiDetayViewController.swift
//  Kişiler Uygulaması
//
//  Created by Jacob on 19.08.2023.
//

import UIKit

class Kis_iDetayViewController: UIViewController {
    var kisi : Kisiler?
    @IBOutlet weak var kisiAdLabel: UILabel!
    
    
    @IBOutlet weak var MobileNumberLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if let k = kisi {
            kisiAdLabel.text = k.kisi_name
            MobileNumberLabel.text = k.kisi_number
            
        }    }
    


}
