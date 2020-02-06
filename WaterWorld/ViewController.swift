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
    @IBOutlet weak var Slider: UISlider!
    @IBOutlet weak var TimerLabel: UILabel!
    @IBOutlet weak var Status: UILabel!
    let defaults = UserDefaults.standard
    var sliderVal = Float(3)
    override func viewDidLoad() {
        super.viewDidLoad()
        if defaults.bool(forKey: "ON") == true {
            Status.text="Reminders are currently: ON"
        }else{
            Status.text="Reminders are currently: OFF"
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
        
    }
    @IBAction func onStopClick(_ sender: UIButton) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            Status.text="Reminders are currently: OFF"
        defaults.set(false, forKey: "ON")
    }
    @IBAction func onSliderChange(_ sender: UISlider) {
        sliderVal = (roundf(Slider.value*11*10)/10) + 1
        TimerLabel.text = "Every "+"\(sliderVal)"+" hours."
    }
    @IBAction func onSetTimer(_ sender: UIButton) {
        print(sliderVal)
        defaults.set(sliderVal, forKey: "timeInterval")
    }
    
}

