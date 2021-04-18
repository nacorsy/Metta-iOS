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
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = UserDefaults.standard.value(forKey:"Meditation") as? Data {
            meditations = try! PropertyListDecoder().decode(Array<Meditation>.self, from: data)
        }
        let homeDirURL = URL(fileURLWithPath: NSHomeDirectory())
        print(homeDirURL.path)
    }
    
    //hide navigation bar di home-page, dan munculin navigation bar di VC lain
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
        
        let meditationDetailVC = MeditationDetailViewController(nibName: "MeditationDetailViewController", bundle: nil)
        meditationDetailVC.meditationIndexPath = indexPath.row
        self.navigationController?.pushViewController(meditationDetailVC, animated: true)
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

