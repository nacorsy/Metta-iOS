//
//  ViewController.swift
//  Metta
//
//  Created by Yossan Sandi Rahmadi on 06/04/21.
//

import UIKit
import SwiftyGif

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        tableView.showsVerticalScrollIndicator = false
        
    }

    //menampilkan berapa banyak data yang ingin dimunculkan di table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //menampilkan data sejumlah data yang ada di array
        return meditations.count
    }
    //tinggi dari cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 258
    }
    
    //ketika click cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "showMeditationDetailIdentifier", sender: self)
    }
    
    //Ke page meditation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailVC {
            destination.meditation = meditations[(tableView.indexPathForSelectedRow?.row)!]
            destination.title = "\(meditations[(tableView.indexPathForSelectedRow?.row)!].name)"
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //minta tableView untuk menampilkan cell dari cell yang sudah dibuat dengan identifier ... di lokasi index TableView berupa indexPath. dan cell ini kepemilikan dari MeditationCell
        let cell = (tableView.dequeueReusableCell(withIdentifier: "meditationCellIdentifier", for: indexPath) as? MeditationCell)!
        
        cell.detailNameLabel.text = meditations[indexPath.row].name
        cell.detailDescLabel.text = meditations[indexPath.row].caption
        
        
        // MARK : Konfigurasi Tulisan Current Session Antar Meditasi
        if (indexPath.row == 0){
            cell.detailSessionLabel.text = "Daily"
        }
        else
        {
            cell.detailSessionLabel.text = "\(meditations[indexPath.row].currentSession)/10"
        }
        
        cell.detailCard.backgroundColor = UIColor(named: "meditate-bg-\(indexPath.row)")
        cell.imageCard.backgroundColor = UIColor(named: "meditate-fg-\(indexPath.row)")
        
        //pasang gif
        do {
            let gif = try UIImage(gifName: "medi-pic-\(indexPath.row)")
            cell.meditationImage.setGifImage(gif, loopCount: -1)
            cell.meditationImage.frame = view.bounds
        } catch {
            print(error)
        }
        return cell
    }
    
    
}

