//
//  MeditationTimerViewController.swift
//  Metta
//
//  Created by Yossan Sandi Rahmadi on 08/04/21.
//

import UIKit
import SwiftyGif
import AVFoundation

class MeditationTimerViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var soundBtn: UIButton!
    @IBOutlet weak var meditateAnimation: UIImageView!
    @IBOutlet weak var meditationBg: UIImageView!
    @IBOutlet weak var cheatBtn: UIButton!
    
    var whiteNoiseSound: AVAudioPlayer!
    var meditationSound: AVAudioPlayer!
    
    let largeConfig = UIImage.SymbolConfiguration(pointSize: 140, weight: .bold, scale: .large)
    var unmute = true
    
    var runCount = 5
    var timer = Timer()
    
    var meditationIndexPath = 0
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cheatBtn.alpha = 0.1
        
        self.view.backgroundColor = UIColor(named: "meditate-fg-\(meditationIndexPath)")
        
        print("meditate-bg-\(meditationIndexPath)")
        
        meditationBg.setImage(UIImage(named: "meditate-bg-\(meditationIndexPath)") ?? UIImage())
        meditationBg.alpha = 0.5
        
        stopBtn.layer.cornerRadius = 8
        
        let speakerIcon = UIImage(systemName: "speaker.wave.2.circle.fill", withConfiguration: largeConfig)
        
        soundBtn.setImage(speakerIcon, for: .normal)
        
        let pathWhiteNoiseSound = Bundle.main.path(forResource: "Forest 1m", ofType: "mp3")!
        let urlWhiteNoiseSound = URL(fileURLWithPath: pathWhiteNoiseSound)
        
        let pathMeditationSound = Bundle.main.path(forResource: "meditate-sound-\(meditationIndexPath)", ofType: "m4a")!
        let urlMeditationSound = URL(fileURLWithPath: pathMeditationSound)
        
        do {
            whiteNoiseSound = try AVAudioPlayer(contentsOf: urlWhiteNoiseSound)
            whiteNoiseSound.volume = 0.3
            whiteNoiseSound.numberOfLoops = -1
            
            meditationSound = try AVAudioPlayer(contentsOf: urlMeditationSound)
            meditationSound.numberOfLoops = -1
            
            meditationSound.play()
            whiteNoiseSound.play()
        } catch {
            print(error)
        }
        
        do {
            let gif = try UIImage(gifName: "meditate-animation-\(meditationIndexPath)")
            self.meditateAnimation.setGifImage(gif, loopCount: -1)
        } catch {
            print(error)
        }
        
        let time = secondsToMinutesSeconds(seconds: runCount)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        timeLabel.text = timeString
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCounter), userInfo: nil, repeats: true)
    }
    
    @IBAction func stopBtnPressed(_ sender: UIButton) {
        timer.invalidate()
        
        meditationSound.pause()
        
        let alert = UIAlertController(title: "Are you sure?", message: "If you stop, you have to restart this session.", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            self.dismiss(animated: false, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action) in
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCounter), userInfo: nil, repeats: true)
            self.meditationSound.play()
        }))
        
        self.present(alert, animated: true)
        
    }
    
    @IBAction func soundBtnPressed(_ sender: UIButton) {
        var speakerIcon: UIImage
        if unmute {
            speakerIcon = UIImage(systemName: "speaker.slash.circle.fill", withConfiguration: largeConfig) ?? UIImage()
            
            soundBtn.setImage(speakerIcon, for: .normal)
            whiteNoiseSound.pause()
        } else {
            speakerIcon = UIImage(systemName: "speaker.wave.2.circle.fill", withConfiguration: largeConfig) ?? UIImage()
            
            soundBtn.setImage(speakerIcon, for: .normal)
            whiteNoiseSound.play()
        }
        unmute = !unmute
    }
    
    @IBAction func cheatBtnPressed(_ sender: UIButton) {
        timer.invalidate()
        meditationSound.stop()
        whiteNoiseSound.stop()
        
        
        
        if !meditations[meditationIndexPath].isDaily {
            if (meditations[meditationIndexPath].currentSession < (meditations[meditationIndexPath].totalSession - 1) ) {
                meditations[meditationIndexPath].currentSession += 1
                defaults.set(try? PropertyListEncoder().encode(meditations), forKey:"Meditation")
            } else {
                meditations[meditationIndexPath].currentSession = 0
                defaults.set(try? PropertyListEncoder().encode(meditations), forKey:"Meditation")
            }
        }
        
        let congratulationVC = CongratulationViewController(nibName: "CongratulationViewController", bundle: nil)
        congratulationVC.modalPresentationStyle = .fullScreen
        
        self.present(congratulationVC, animated: true, completion: nil)
    }
    
    
    @objc func timerCounter() {
        runCount -= 1
        
        let time = secondsToMinutesSeconds(seconds: runCount)
        let timeString = makeTimeString(minutes: time.0, seconds: time.1)
        timeLabel.text = timeString
        
        if runCount == 0 {
            timer.invalidate()
            meditationSound.stop()
            whiteNoiseSound.stop()
            
            if !meditations[meditationIndexPath].isDaily {
                meditations[meditationIndexPath].currentSession += 1
                
                if (meditations[meditationIndexPath].currentSession < meditations[meditationIndexPath].totalSession) {
                    defaults.setValue(meditations, forKey: "Meditation")
                } else {
                    defaults.setValue(meditations, forKey: "Meditation")
                }
            }
            
            let congratulationVC = CongratulationViewController(nibName: "CongratulationViewController", bundle: nil)
            congratulationVC.modalPresentationStyle = .fullScreen
            
            self.present(congratulationVC, animated: true, completion: nil)
        }
    }
    
    func secondsToMinutesSeconds(seconds: Int) -> (Int, Int) {
        return ((seconds / 60), ((seconds % 3600) % 60))
    }
    
    func makeTimeString(minutes: Int, seconds : Int) -> String {
        var timeString = ""
        
        timeString += String(format: "%02d", minutes)
        timeString += ":"
        timeString += String(format: "%02d", seconds)
        
        return timeString
    }
}
