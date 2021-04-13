//
//  MeditationDetailViewController.swift
//  Metta
//
//  Created by Vincent on 08/04/21.
//

import UIKit
import SwiftyGif

class MeditationDetailViewController: UIViewController{

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var buttonPlayAttrib: UIButton!
    @IBOutlet weak var timePicker: UIPickerView!
    @IBOutlet weak var timePickedLabel: UILabel!
    
    @IBOutlet weak var pickerHolderView: UIView!
    @IBOutlet weak var heightHolderConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backgroundViewMeditationDetail: UIView!
    @IBOutlet weak var titleLabelMeditationDetail: UILabel!
    @IBOutlet weak var sessionLabelMeditationDetail: UILabel!
    @IBOutlet weak var imageViewGif: UIImageView!
    
    var dummyData = meditations
    
    let timeArray = [5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180]
    
    var defaultPickerHolderViewHeight: CGFloat = 0.0
    let animationDruation = 0.3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timePicker.dataSource = self
        timePicker.delegate = self

        descriptionLabel.text = dummyData[1].description
        timePicker.selectRow(5, inComponent: 0, animated: true)
        
        buttonPlayAttrib.imageView?.contentMode = .scaleToFill
        buttonPlayAttrib.imageEdgeInsets = UIEdgeInsets(top: 30, left: 37, bottom: 48, right: 30)
        
        let tapShow = UITapGestureRecognizer(target: self, action: #selector(tapFunction(gestureRecognizer:)))
        timePickedLabel.addGestureRecognizer(tapShow)
        timePickedLabel.isUserInteractionEnabled = true
        
        defaultPickerHolderViewHeight = heightHolderConstraint.constant
        
        do{
            let gif = try UIImage(gifName: "medi-pic-0.gif")
            self.imageViewGif.setGifImage(gif, loopCount: -1)
        }catch{
            print(error)
        }
    }

    
    //function hide UIPickerView
    @objc func tapFunction(gestureRecognizer: UITapGestureRecognizer){
        // local bool
        let bIsHidden = pickerHolderView.isHidden

        var t = CGAffineTransform.identity

        // if the picker holder view is currently hidden, show it
        if bIsHidden {
            pickerHolderView.isHidden = false
        } else {
            // we're going to hide it
            t = CGAffineTransform(scaleX: 0.5, y: 0.01)
        }

        // if picker holder height constant is > 0 (it's open / showing)
        //      set it to 0
        // else
        //      set it to defaultPickerHolderViewHeight
        self.heightHolderConstraint.constant = self.heightHolderConstraint.constant > 0 ? 0 : defaultPickerHolderViewHeight

        // animate the change
        UIView.animate(withDuration: animationDruation, animations: {
            self.timePicker.transform = t
            self.view.layoutIfNeeded()
        }) { finished in
            // if the picker holder view was showing (NOT hidden)
            //  hide it
            if !bIsHidden {
                self.pickerHolderView.isHidden = true
            }
        }
    }
    
    //button passing data to timer page
    @IBAction func buttonPlay(_ sender: UIButton) {
        let timePicked = timePicker.selectedRow(inComponent: 0)
        let timePickedAdd = (timePicked * 5) + 5
        
        print(timePickedAdd)
    }
    
}

extension MeditationDetailViewController: UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        timeArray.count
    }
    
}

extension MeditationDetailViewController: UIPickerViewDelegate{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let testAja = timeArray[row]
        return String(format: "\(testAja):00", row)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let timePicked = pickerView.selectedRow(inComponent: component)
        let timePickedAdd = (timePicked * 5) + 5
        
        timePickedLabel.text = "\(timePickedAdd) min"
    }
}
