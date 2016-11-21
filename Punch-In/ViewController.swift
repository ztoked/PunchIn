//
//  ViewController.swift
//  Punch-In
//
//  Created by Zach Halvorsen on 9/23/16.
//  Copyright © 2016 Zach Halvorsen. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    struct defaultsKeys {
        static let punched = "punched"
        static let lastTime = "lastTime"
        
        static let mondayBegin = "mondayBegin"
        static let mondayEnd = "mondayEnd"
        static let mondayTime = "mondayTime"
        
        static let tuesdayBegin = "tuesdayBegin"
        static let tuesdayEnd = "tuesdayEnd"
        static let tuesdayTime = "tuesdayTime"
        
        static let wednesdayBegin = "wednesdayBegin"
        static let wednesdayEnd = "wednesdayEnd"
        static let wednesdayTime = "wednesdayTime"
        
        static let thursdayBegin = "thursdayBegin"
        static let thursdayEnd = "thursdayEnd"
        static let thursdayTime = "thursdayTime"
        
        static let fridayBegin = "fridayBegin"
        static let fridayEnd = "fridayEnd"
        static let fridayTime = "fridayTime"
        
        static let saturdayBegin = "saturdayBegin"
        static let saturdayEnd = "saturdayEnd"
        static let saturdayTime = "saturdayTime"
    }
    
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var punchIn: UIButton!
    @IBOutlet weak var punchOut: UIButton!
    @IBOutlet weak var clear: UIButton!
    
    @IBOutlet weak var weeklyTotal: UITextField!
    @IBOutlet weak var mondayBegin: UIButton!
    @IBOutlet weak var mondayEnd: UIButton!
    @IBOutlet weak var tuesdayBegin: UIButton!
    @IBOutlet weak var tuesdayEnd: UIButton!
    @IBOutlet weak var wednesdayBegin: UIButton!
    @IBOutlet weak var wednesdayEnd: UIButton!
    @IBOutlet weak var thursdayBegin: UIButton!
    @IBOutlet weak var thursdayEnd: UIButton!
    @IBOutlet weak var fridayBegin: UIButton!
    @IBOutlet weak var fridayEnd: UIButton!
    @IBOutlet weak var saturdayBegin: UIButton!
    @IBOutlet weak var saturdayEnd: UIButton!
    @IBOutlet weak var done: UIButton!
    
    @IBOutlet weak var closeTime: UIButton!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    @IBOutlet weak var tuesdayText: UITextField!
    @IBOutlet weak var tuesdayBeginText: UITextField!
    @IBOutlet weak var tuesdayEndText: UITextField!
    @IBOutlet weak var tuesdayTimeText: UITextField!
    @IBOutlet weak var tuesdayCurTime: UITextField!
    @IBOutlet weak var wednesdayText: UITextField!
    @IBOutlet weak var wednesdayBeginText: UITextField!
    @IBOutlet weak var wednesdayTimeText: UITextField!
    @IBOutlet weak var wednesdayEndText: UITextField!
    @IBOutlet weak var wednesdayCurTime: UITextField!
    @IBOutlet weak var thursdayText: UITextField!
    @IBOutlet weak var thursdayBeginText: UITextField!
    @IBOutlet weak var thursdayTimeText: UITextField!
    @IBOutlet weak var thursdayEndText: UITextField!
    @IBOutlet weak var thursdayCurTime: UITextField!
    @IBOutlet weak var mondayCurTime: UITextField!
    @IBOutlet weak var fridayCurTime: UITextField!
    @IBOutlet weak var saturdayCurTime: UITextField!
    
    var weekDay = Int()
    var curHour = Int()
    var curMinutes = Int()
    var curSeconds = Int()
    var punched = false
    
    weak var buttonPressed: UIButton?
    weak var pressedBegin: UIButton?
    weak var pressedEnd: UIButton?
    weak var pressedCurTime: UITextField?
    weak var todayBeginButton: UIButton?
    weak var todayEndButton: UIButton?
    weak var todayCurTime: UITextField?
    
    var updateTimer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        weekDay = getDayOfWeek()!
        
        if let mondayB = defaults.string(forKey: defaultsKeys.mondayBegin) {
            mondayBegin.setTitle(mondayB, for: UIControlState.normal);
        }
        if let mondayE = defaults.string(forKey: defaultsKeys.mondayEnd) {
            mondayEnd.setTitle(mondayE, for: UIControlState.normal);
        }
        if let mondayT = defaults.string(forKey: defaultsKeys.mondayTime) {
            mondayCurTime.text = mondayT
        }
        
        if let tuesdayB = defaults.string(forKey: defaultsKeys.tuesdayBegin) {
            tuesdayBegin.setTitle(tuesdayB, for: UIControlState.normal);
        }
        if let tuesdayE = defaults.string(forKey: defaultsKeys.tuesdayEnd) {
            tuesdayEnd.setTitle(tuesdayE, for: UIControlState.normal);
        }
        if let tuesdayT = defaults.string(forKey: defaultsKeys.tuesdayTime) {
            tuesdayCurTime.text = tuesdayT
        }
        
        if let wednesdayB = defaults.string(forKey: defaultsKeys.wednesdayBegin) {
            wednesdayBegin.setTitle(wednesdayB, for: UIControlState.normal);
        }
        if let wednesdayE = defaults.string(forKey: defaultsKeys.wednesdayEnd) {
            wednesdayEnd.setTitle(wednesdayE, for: UIControlState.normal);
        }
        if let wednesdayT = defaults.string(forKey: defaultsKeys.wednesdayTime) {
            wednesdayCurTime.text = wednesdayT
        }
        
        if let thursdayB = defaults.string(forKey: defaultsKeys.thursdayBegin) {
            thursdayBegin.setTitle(thursdayB, for: UIControlState.normal);
        }
        if let thursdayE = defaults.string(forKey: defaultsKeys.thursdayEnd) {
            thursdayEnd.setTitle(thursdayE, for: UIControlState.normal);
        }
        if let thursdayT = defaults.string(forKey: defaultsKeys.thursdayTime) {
            thursdayCurTime.text = thursdayT
        }
        
        if let fridayB = defaults.string(forKey: defaultsKeys.fridayBegin) {
            fridayBegin.setTitle(fridayB, for: UIControlState.normal);
        }
        if let fridayE = defaults.string(forKey: defaultsKeys.fridayEnd) {
            fridayEnd.setTitle(fridayE, for: UIControlState.normal);
        }
        if let fridayT = defaults.string(forKey: defaultsKeys.fridayTime) {
            mondayCurTime.text = fridayT
        }
        
        if let saturdayB = defaults.string(forKey: defaultsKeys.saturdayBegin) {
            saturdayBegin.setTitle(saturdayB, for: UIControlState.normal);
        }
        if let saturdayE = defaults.string(forKey: defaultsKeys.saturdayEnd) {
            saturdayEnd.setTitle(saturdayE, for: UIControlState.normal);
        }
        if let saturdayT = defaults.string(forKey: defaultsKeys.saturdayTime) {
            saturdayCurTime.text = saturdayT
        }
        
        switch(weekDay) {
        case 2:
            todayBeginButton = mondayBegin;
            todayEndButton = mondayEnd;
            todayCurTime = mondayCurTime;
            break;
        case 3:
            todayBeginButton = tuesdayBegin;
            todayEndButton = tuesdayEnd;
            todayCurTime = tuesdayCurTime;
            break;
        case 4:
            todayBeginButton = wednesdayBegin;
            todayEndButton = wednesdayEnd;
            todayCurTime = wednesdayCurTime;
            break;
        case 5:
            todayBeginButton = thursdayBegin;
            todayEndButton = thursdayEnd;
            todayCurTime = thursdayCurTime;
            break;
        case 6:
            todayBeginButton = fridayBegin;
            todayEndButton = fridayEnd;
            todayCurTime = fridayCurTime;
            break;
        case 7:
            todayBeginButton = saturdayBegin;
            todayEndButton = saturdayEnd;
            todayCurTime = saturdayCurTime;
            break;
        default:
            break;
        }
        
        if let isPunched = defaults.string(forKey: defaultsKeys.punched) {
            if(isPunched == "true") {
                punched = true
                updateEndTimeAfterPause()
            }
        }
        
        updateTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.updateTimeTimer), userInfo: nil, repeats: true)
    }
    
    func getDayOfWeek() -> Int? {
        let date = NSDate()
        let calendar = Calendar(identifier: .gregorian)
        let weekDay = calendar.component(.weekday, from: date as Date)
        return weekDay
    }
    
    func updateCurTime() {
        let date = NSDate()
        let calendar = Calendar(identifier: .gregorian)
        curHour = calendar.component(.hour, from: date as Date)
        curMinutes = calendar.component(.minute, from: date as Date)
        curSeconds = calendar.component(.second, from: date as Date)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func punchInAction(_ sender: UIButton) {
        if !punched {
            updateCurTime()
            if(todayBeginButton?.title(for: UIControlState.normal) == "00:00:00") {
                todayBeginButton?.setTitle(String(format: "%02d:%02d:%02d", curHour, curMinutes, curSeconds), for: UIControlState.normal);
            }
            punched = true
        }
    }
    
    @IBAction func punchOutAction(_ sender: UIButton) {
        updateTimeTimer()
        punched = false
    }
    
    func getTimeInterval(begin: String, end: String) -> Double {
        let beginHour = Double(begin.substring(to: begin.index(begin.startIndex, offsetBy: 2)))
        let beginMin = Double(begin.substring(with: begin.index(begin.startIndex, offsetBy: 3)..<begin.index(begin.startIndex, offsetBy: 5)))! / 60.0
        let beginSec = Double(begin.substring(with: begin.index(begin.startIndex, offsetBy: 6)..<begin.endIndex))! / 3600.0
        let beginTime = beginHour! + beginMin + beginSec
        
        let endHour = Double(end.substring(to: end.index(end.startIndex, offsetBy: 2)))
        let endMin = Double(end.substring(with: end.index(end.startIndex, offsetBy: 3)..<end.index(end.startIndex, offsetBy: 5)))! / 60.0
        let endSec = Double(end.substring(with: end.index(end.startIndex, offsetBy: 6)..<end.endIndex))! / 3600.0
        let endTime = endHour! + endMin + endSec
        
        let totalTime = endTime - beginTime
        if totalTime > 0 {
            return totalTime
        }
        else {
            return 0.0
        }
    }
    
    func updateWeeklyTotal() {
        let total = Double(mondayCurTime.text!)!
                        + Double(tuesdayCurTime.text!)!
                        + Double(wednesdayCurTime.text!)!
                        + Double(thursdayCurTime.text!)!
                        + Double(fridayCurTime.text!)!
                        + Double(saturdayCurTime.text!)!
        weeklyTotal.text = String(format: "%.2f", total)
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        mondayBegin.setTitle("00:00:00", for: UIControlState.normal);
        mondayEnd.setTitle("00:00:00", for: UIControlState.normal);
        tuesdayBegin.setTitle("00:00:00", for: UIControlState.normal);
        tuesdayEnd.setTitle("00:00:00", for: UIControlState.normal);
        wednesdayBegin.setTitle("00:00:00", for: UIControlState.normal);
        wednesdayEnd.setTitle("00:00:00", for: UIControlState.normal);
        thursdayBegin.setTitle("00:00:00", for: UIControlState.normal);
        thursdayEnd.setTitle("00:00:00", for: UIControlState.normal);
        fridayBegin.setTitle("00:00:00", for: UIControlState.normal);
        fridayEnd.setTitle("00:00:00", for: UIControlState.normal);
        saturdayBegin.setTitle("00:00:00", for: UIControlState.normal);
        saturdayEnd.setTitle("00:00:00", for: UIControlState.normal);
        mondayCurTime.text = "0.00"
        tuesdayCurTime.text = "0.00"
        wednesdayCurTime.text = "0.00"
        thursdayCurTime.text = "0.00"
        fridayCurTime.text = "0.00"
        saturdayCurTime.text = "0.00"
        weeklyTotal.text = "0.00"
        punched = false
    }

    @IBAction func mondayBeginAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func mondayEndAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func tuesdayBeginAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func tuesdayEndAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func wednesdayBeginAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func wednesdayEndAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func thursdayBeginAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func thursdayEndAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func fridayBeginAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func fridayEndAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    @IBAction func saturdayBeginAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func saturdayEndAction(_ sender: UIButton) {
        showTimePicker()
        buttonPressed = sender
    }
    
    @IBAction func doneAction(_ sender: UIButton) {
        hideTimePicker()
        setTimeChosen()
        synchronizeValues()
    }
    
    @IBAction func closeTimeAction(_ sender: UIButton) {
        hideTimePicker()
        updatePressedGlobals();
        pressedCurTime?.text = String(format: "%.2f", getTimeInterval(begin: (pressedBegin?.title(for: UIControlState.normal)!)!, end: (pressedEnd?.title(for: UIControlState.normal)!)!))
        synchronizeValues()
    }
    
    func updatePressedGlobals() {
        switch buttonPressed {
        case mondayBegin?, mondayEnd?:
            pressedBegin = mondayBegin;
            pressedEnd = mondayEnd;
            pressedCurTime = mondayCurTime;
            break;
        case tuesdayBegin?, tuesdayEnd?:
            pressedBegin = tuesdayBegin;
            pressedEnd = tuesdayEnd;
            pressedCurTime = tuesdayCurTime;
            break;
        case wednesdayBegin?, wednesdayEnd?:
            pressedBegin = wednesdayBegin;
            pressedEnd = wednesdayEnd;
            pressedCurTime = wednesdayCurTime;
            break;
        case thursdayBegin?, thursdayEnd?:
            pressedBegin = thursdayBegin;
            pressedEnd = thursdayEnd;
            pressedCurTime = thursdayCurTime;
            break;
        case fridayBegin?, fridayEnd?:
            pressedBegin = fridayBegin;
            pressedEnd = fridayEnd;
            pressedCurTime = fridayCurTime;
            break;
        case saturdayBegin?, saturdayEnd?:
            pressedBegin = saturdayBegin;
            pressedEnd = saturdayEnd;
            pressedCurTime = saturdayCurTime;
            break;
        default:
            break;
        }
    }
    
    func updateTimeTimer()
    {
        if punched {
            if(todayEndButton?.title(for: UIControlState.normal) == "00:00:00")
            {
                todayEndButton?.setTitle(String(format: "%02d:%02d:%02d", curHour, curMinutes, curSeconds), for: UIControlState.normal);
            }
            else
            {
                todayEndButton?.setTitle(incTime(time: (todayEndButton?.title(for: UIControlState.normal)!)!), for: UIControlState.normal);
            }
            todayCurTime?.text = String(format: "%.2f", getTimeInterval(begin: (todayBeginButton?.title(for: UIControlState.normal)!)!, end: (todayEndButton?.title(for: UIControlState.normal)!)!))
            updateWeeklyTotal()
        }
        synchronizeValues()
    }
    
    func incTime(time: String) -> String {
        var hour = Int(time.substring(to: time.index(time.startIndex, offsetBy: 2)))!
        var min = Int(time.substring(with: time.index(time.startIndex, offsetBy: 3)..<time.index(time.startIndex, offsetBy: 5)))!
        var sec = Int(time.substring(with: time.index(time.startIndex, offsetBy: 6)..<time.endIndex))!
        if sec == 59 {
            sec = 0
            if min == 59 {
                min = 0
                if hour == 23 {
                    hour = 0
                }
                else {
                    hour += 1
                }
            }
            else
            {
                min += 1
            }
        }
        else
        {
            sec += 1
        }
        return String(format: "%02d:%02d:%02d", hour, min, sec)
    }
    
    func updateEndTimeAfterPause() {
        if let lastTime = defaults.string(forKey: defaultsKeys.lastTime) {
            todayEndButton?.setTitle(incTimeByPause(end: (todayEndButton?.title(for: UIControlState.normal)!)!, last: lastTime), for: UIControlState.normal);
        }
    }
    
    func incTimeByPause(end: String, last: String) -> String {
        updateCurTime()
        
        let lastHour = Int(last.substring(to: last.index(last.startIndex, offsetBy: 2)))!
        let lastMin = Int(last.substring(with: last.index(last.startIndex, offsetBy: 3)..<last.index(last.startIndex, offsetBy: 5)))!
        let lastSec = Int(last.substring(with: last.index(last.startIndex, offsetBy: 6)..<last.endIndex))!
        
        if(curSeconds - lastSec < 0 ) {
            curMinutes -= 1
            curSeconds = curSeconds + 60 - lastSec
        }
        else {
            curSeconds -= lastSec
        }
        if(curMinutes - lastMin < 0) {
            curHour -= 1
            curMinutes = curMinutes + 60 - lastMin
        }
        else {
            curMinutes -= lastMin
        }
        if(curHour - lastHour < 0) {
            return "00:00:00"
        }
        else {
            curHour -= lastHour
        }
        
        var endHour = Int(end.substring(to: end.index(end.startIndex, offsetBy: 2)))!
        var endMin = Int(end.substring(with: end.index(end.startIndex, offsetBy: 3)..<end.index(end.startIndex, offsetBy: 5)))!
        var endSec = Int(end.substring(with: end.index(end.startIndex, offsetBy: 6)..<end.endIndex))!
        
        if(endSec + curSeconds > 59) {
            endMin += 1
            endSec = endSec + curSeconds - 60
        }
        else {
            endSec += curSeconds
        }
        if(endMin + curMinutes > 59) {
            endHour += 1
            endMin = endMin + curMinutes - 60
        }
        else {
            endMin += curMinutes
        }
        if(endHour + curHour > 23) {
            return "00:00:00"
        }
        else {
            endHour += curHour
        }
        
        return String(format: "%02d:%02d:%02d", endHour, endMin, endSec)
    }
    
    func synchronizeValues() {
        if(punched) {
            defaults.setValue("true", forKey: defaultsKeys.punched)
        }
        else {
            defaults.setValue("false", forKey: defaultsKeys.punched)
        }
        
        defaults.setValue(String(format: "%02d:%02d:%02d", curHour, curMinutes, curSeconds), forKey: defaultsKeys.lastTime)
        
        defaults.setValue(mondayBegin.title(for: UIControlState.normal), forKey: defaultsKeys.mondayBegin)
        defaults.setValue(mondayEnd.title(for: UIControlState.normal), forKey: defaultsKeys.mondayEnd)
        defaults.setValue(mondayCurTime.text, forKey: defaultsKeys.mondayTime)
        
        
        defaults.setValue(tuesdayBegin.title(for: UIControlState.normal), forKey: defaultsKeys.tuesdayBegin)
        defaults.setValue(tuesdayEnd.title(for: UIControlState.normal), forKey: defaultsKeys.tuesdayEnd)
        defaults.setValue(tuesdayCurTime.text, forKey: defaultsKeys.tuesdayTime)
        
        defaults.setValue(wednesdayBegin.title(for: UIControlState.normal), forKey: defaultsKeys.wednesdayBegin)
        defaults.setValue(wednesdayEnd.title(for: UIControlState.normal), forKey: defaultsKeys.wednesdayEnd)
        defaults.setValue(wednesdayCurTime.text, forKey: defaultsKeys.wednesdayTime)
        
        defaults.setValue(thursdayBegin.title(for: UIControlState.normal), forKey: defaultsKeys.thursdayBegin)
        defaults.setValue(thursdayEnd.title(for: UIControlState.normal), forKey: defaultsKeys.thursdayEnd)
        defaults.setValue(thursdayCurTime.text, forKey: defaultsKeys.thursdayTime)
        
        defaults.setValue(fridayBegin.title(for: UIControlState.normal), forKey: defaultsKeys.fridayBegin)
        defaults.setValue(fridayEnd.title(for: UIControlState.normal), forKey: defaultsKeys.fridayEnd)
        defaults.setValue(fridayCurTime.text, forKey: defaultsKeys.fridayTime)
        
        defaults.setValue(saturdayBegin.title(for: UIControlState.normal), forKey: defaultsKeys.saturdayBegin)
        defaults.setValue(saturdayEnd.title(for: UIControlState.normal), forKey: defaultsKeys.saturdayEnd)
        defaults.setValue(saturdayCurTime.text, forKey: defaultsKeys.saturdayTime)
        
        
        defaults.synchronize()
    }
    
    func setTimeChosen() {
        let date = timePicker.date
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: date as Date)
        let min = calendar.component(.minute, from: date as Date)
        updatePressedGlobals();
        buttonPressed?.setTitle(String(format: "%02d:%02d:00", hour, min), for: UIControlState.normal);
        pressedCurTime?.text = String(format: "%.2f", getTimeInterval(begin: (pressedBegin?.title(for: UIControlState.normal)!)!, end: (pressedEnd?.title(for: UIControlState.normal)!)!))
    }
    
    func showTimePicker() {
        done.alpha = 1.0
        done.isEnabled = true
        timePicker.alpha = 1.0
        timePicker.isEnabled = true
        closeTime.alpha = 1.0
        closeTime.isEnabled = true
        
        tuesdayText.alpha = 0.0
        tuesdayBeginText.alpha = 0.0
        tuesdayEndText.alpha = 0.0
        tuesdayTimeText.alpha = 0.0
        tuesdayCurTime.alpha = 0.0
        tuesdayEnd.alpha = 0.0
        tuesdayBegin.alpha = 0.0
        wednesdayText.alpha = 0.0
        wednesdayBeginText.alpha = 0.0
        wednesdayTimeText.alpha = 0.0
        wednesdayEndText.alpha = 0.0
        wednesdayCurTime.alpha = 0.0
        wednesdayEnd.alpha = 0.0
        wednesdayBegin.alpha = 0.0
        thursdayText.alpha = 0.0
        thursdayBeginText.alpha = 0.0
        thursdayTimeText.alpha = 0.0
        thursdayEndText.alpha = 0.0
        thursdayCurTime.alpha = 0.0
        thursdayEnd.alpha = 0.0
        thursdayBegin.alpha = 0.0
    }
    
    func hideTimePicker() {
        done.alpha = 0.0
        done.isEnabled = false
        timePicker.alpha = 0.0
        timePicker.isEnabled = false
        closeTime.alpha = 0.0
        closeTime.isEnabled = false
        
        tuesdayText.alpha = 1.0
        tuesdayBeginText.alpha = 1.0
        tuesdayEndText.alpha = 1.0
        tuesdayTimeText.alpha = 1.0
        tuesdayCurTime.alpha = 1.0
        tuesdayEnd.alpha = 1.0
        tuesdayBegin.alpha = 1.0
        wednesdayText.alpha = 1.0
        wednesdayBeginText.alpha = 1.0
        wednesdayTimeText.alpha = 1.0
        wednesdayEndText.alpha = 1.0
        wednesdayCurTime.alpha = 1.0
        wednesdayEnd.alpha = 1.0
        wednesdayBegin.alpha = 1.0
        thursdayText.alpha = 1.0
        thursdayBeginText.alpha = 1.0
        thursdayTimeText.alpha = 1.0
        thursdayEndText.alpha = 1.0
        thursdayCurTime.alpha = 1.0
        thursdayEnd.alpha = 1.0
        thursdayBegin.alpha = 1.0
    }
    
    
}

