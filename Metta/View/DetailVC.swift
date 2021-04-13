//
//  DetailVC.swift
//  Metta
//
//  Created by Novi Gunawan on 11/04/21.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var meditationNameLabel: UILabel!
    
    var meditation: Meditation!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        meditationNameLabel.text = "You tapped the page of \(meditation.name) Meditation"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
