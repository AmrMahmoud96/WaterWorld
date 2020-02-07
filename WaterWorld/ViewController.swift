//
//  ViewController.swift
//  WaterWorld
//
//  Created by Amr Mahmoud on 2020-02-04.
//  Copyright © 2020 Amr Mahmoud. All rights reserved.
//

import UIKit
import UserNotificationsUI
import UserNotifications

class ViewController: UIViewController {
//    let nc = NotificationCenter.default
    @IBOutlet weak var timerView: UIStackView!
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var currTimer: UILabel!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var Status: UILabel!
    let defaults = UserDefaults.standard
    var sliderVal = Float(3)
    var t: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.bool(forKey: "ON") == true {
            Status.text="Reminders are currently: ON"
            timerView.isHidden = false
            timerOn()
        }else{
            Status.text="Reminders are currently: OFF"
            timerView.isHidden = true
            timerOff()
        }
        if defaults.object(forKey: "timeInterval") == nil {
            defaults.set(sliderVal,forKey:"timeInterval")
        }else{
            sliderVal = defaults.float(forKey: "timeInterval")
        }
        print(sliderVal)
        TimerLabel.text = "Every "+"\(sliderVal)"+" hours."
        Slider.value = (sliderVal-1)/11
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func timerOn(){
        
        guard t == nil else { return }
        t = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {(_) in
            
            if let date = self.defaults.object(forKey: "activatedOn") as? Date{
                let x = Int(Date().timeIntervalSince(date))
                let interval = Int(self.defaults.float(forKey: "timeInterval") * 3600)
                let diff = interval - (x % interval)
                let hours = (diff / 3600)
                let minutes = (diff / 60) % 60
                let seconds = (diff % 60)
                self.currTimer.text = String(format: "%02d:%02d:%02d",hours,minutes,seconds)
                
            }
        }
        t?.fire()
        
    }
    
    func timerOff(){
        t?.invalidate()
        t=nil
    }
    
    @IBAction func onStartClick(_ sender: UIButton) {
        
        let content: UNMutableNotificationContent = UNMutableNotificationContent()
        
        content.title = "Drink Water"
        content.body = "It's time to drink water."
        content.sound = UNNotificationSound.default
        //        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: (180*60), repeats: true)
        print(sliderVal)
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: (Double(sliderVal*60*60)), repeats: true)
        
        let request = UNNotificationRequest(identifier: "NewWaterAlarm",
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        {
            (error) in // ...
        }
        defaults.set(true, forKey: "ON")
        Status.text="Reminders are currently: ON"
        timerView.isHidden = false
        defaults.set(Date(),forKey:"activatedOn")
        timerOn()
    }
    @IBAction func onStopClick(_ sender: UIButton) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            Status.text="Reminders are currently: OFF"
        defaults.set(false, forKey: "ON")
        timerView.isHidden = true
        timerOff()
    }
    @IBAction func onSliderChange(_ sender: UISlider) {
        sliderVal = (roundf(Slider.value*11*10)/10) + 1
        TimerLabel.text = "Every "+"\(sliderVal)"+" hours."
        Slider.minimumTrackTintColor = UIColor.init(red: 21/255, green: 126/255, blue: 251/255, alpha: 1)
    }
    @IBAction func onSetTimer(_ sender: UIButton) {
        print(sliderVal)
        defaults.set(sliderVal, forKey: "timeInterval")
        Slider.minimumTrackTintColor = UIColor.init(red: 15/255, green: 175/255, blue: 0/255, alpha: 1)
    }
    
}

