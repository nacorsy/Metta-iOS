//
//  ViewController.swift
//  Metta
//
//  Created by Yossan Sandi Rahmadi on 06/04/21.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.showsVerticalScrollIndicator = false
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        //minta tableView untuk menampilkan cell dari cell yang sudah dibuat dengan identifier ... di lokasi index TableView berupa indexPath. dan cell ini kepemilikan dari MeditationCell
        let cell = (tableView.dequeueReusableCell(withIdentifier: "meditationCellIdentifier", for: indexPath) as? MeditationCell)!
        
        cell.detailNameLabel.text = meditations[indexPath.row].name
        cell.detailDescLabel.text = meditations[indexPath.row].caption
        
        
        if (indexPath.row == 0){
            cell.detailSessionLabel.text = "Daily"
            
            cell.meditationImage.image = UIImage(named: "breathe-meditation")
        }
        else
        {
            cell.detailSessionLabel.text = "\(meditations[indexPath.row].currentSession)/10"
        }
        
        cell.detailCard.backgroundColor = UIColor(named: "meditate-bg-\(indexPath.row)")
        cell.imageCard.backgroundColor = UIColor(named: "meditate-fg-\(indexPath.row)")
        
        return cell
    }
    
    
}

