//
//  ViewController.swift
//  Kişiler Uygulaması
//
//  Created by Jacob on 19.08.2023.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate

class ViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var kisilerTableView: UITableView!
    
    let context = appDelegate.persistentContainer.viewContext
    
    
    var kisilerListesi = [Kisiler]()
    var isSearchingName = false
    var searchWord : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        kisilerTableView.delegate = self
        kisilerTableView.dataSource = self

        searchBar.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
        if isSearchingName{
            searchPeople(kisi_name: searchWord!)
        }else{
            takeAllPeople()
        }
        kisilerTableView.reloadData()
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     let indeks = sender as? Int
        
        if segue.identifier == "toDetay"{
            let gidilecekVC = segue.destination as! Kis_iDetayViewController
            gidilecekVC.kisi = kisilerListesi[indeks!]
            
            
        }
        if segue.identifier == "toGüncelle"{
            let gidilecekVC = segue.destination as! Kis_iGu_ncelleViewController
            gidilecekVC.kisi = kisilerListesi[indeks!]
            
        }
    }
    
    func takeAllPeople(){
        do{
            kisilerListesi = try context.fetch(Kisiler.fetchRequest()) // Veri Çekmek
        }
        catch{
            print(error)
        }
    }
    func searchPeople(kisi_name: String) {
        let fetchRequest: NSFetchRequest<Kisiler> = Kisiler.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "kisi_name CONTAINS %@", kisi_name)
        do {
            kisilerListesi = try context.fetch(fetchRequest)
        } catch {
            print(error)
        }
    }


}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return kisilerListesi.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kisi = kisilerListesi[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "kisiHucre",for: indexPath) as! kisiHucreTableViewCell

        if let kisiName = kisi.kisi_name, let kisiNumber = kisi.kisi_number {
            cell.kisiYaziLabel.text = "\(kisiName) - \(kisiNumber)"
        } else if let kisiName = kisi.kisi_name {
            cell.kisiYaziLabel.text = kisiName
        } else if let kisiNumber = kisi.kisi_number {
            cell.kisiYaziLabel.text = kisiNumber
        } else {
            cell.kisiYaziLabel.text = ""
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction,view,boolValue) in
        //    print("Clicked Deletion \(self.kisilerListesi[indexPath.row])")
            let kisi = self.kisilerListesi[indexPath.row]
            self.context.delete(kisi)
            appDelegate.saveContext()
            if self.isSearchingName{
                self.searchPeople(kisi_name: self.searchWord!)
            }else{
                self.takeAllPeople()
            }
            
            self.kisilerTableView.reloadData()
        }
        let guncelleAction = UIContextualAction(style: .normal, title: "Update") { (contextualAction,view,boolValue) in
          
            // print("Clicked Update \(self.kisilerListesi[indexPath.row])")
            
            self.performSegue(withIdentifier: "toGüncelle", sender: indexPath.row)
            
        }
        return UISwipeActionsConfiguration(actions: [silAction,guncelleAction])
        
        
        
    }
    
    
    
}

extension ViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Result : \(searchText)")
        searchWord = searchText
        
        
        searchPeople(kisi_name: searchText)
        if searchText == ""{ // yazıp sildikten sonra arayüzün boş olmayıp tüm hepsini geri getirmesi için yapıldı.
            isSearchingName = false
            takeAllPeople()


        }else{
            isSearchingName = true
            searchPeople(kisi_name: searchWord!)

        }
        kisilerTableView.reloadData()
    }
}
