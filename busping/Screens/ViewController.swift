//  ViewController.swift
//  Kuruyo (previously busping)
//
//  Created by Johnny Linnert, beginning on 2016/09/28 
//  With great help from Greg de Jonckheere and Jonathon Toon
//  Copyright © 2016-2017 Johnny Linnert. All rights reserved.
//


// See below notes about the current status and next steps for this project

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {

    @IBOutlet weak var leftBusesDisplay: UILabel!
    @IBOutlet weak var rightBusesDisplay: UILabel!
    
    @IBAction func refreshBuses(_ sender: Any) {
        gatherBusData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gatherBusData()
    }
    
    func displayBusStops(_ rawMarkup: String) {
        let stops = self.getStops(rawMarkup)
        
        for stop in stops.reversed() {
            print(stop.name)
        }
        
        print()
        print()
    }
    
    func displayLeftBuses(_ rawMarkup: String) {
        let buses = self.getLeftBuses(rawMarkup)
        
        var busStopNames = [String]()
        
        for bus in buses {
            if let stop = bus.stop {
                print("Left Buses leaving", stop.name)
                busStopNames.append(stop.name)
            } else {
                print("Idling bus")
                busStopNames.append("Idling Bus")
            }
        }
        
        leftBusesDisplay.text = busStopNames.joined(separator: "\n")
    }
    
    func displayRightBuses(_ rawMarkup: String) {
        let rightbuses = self.getRightBuses(rawMarkup)
        
        var busStopNames = [String]()
        
        for bus in rightbuses {
            if let stop = bus.stop {
                print("Right Buses leaving", stop.name)
                busStopNames.append(stop.name)
            } else {
                print("Idling bus")
                busStopNames.append("Idling Bus")
            }
        }
        rightBusesDisplay.text = busStopNames.joined(separator: "\n")
    }
    
    //MARK: - Getting Bus Raw Data
    
    func gatherBusData() {
        TokyuBusHTMLRepository().getHTML().onSuccess { html in
            self.displayBusStops(html)
            self.displayLeftBuses(html)
            self.displayRightBuses(html)
        }
    }
    
    //MARK: - Get Busses

    func getLeftBuses(_ rawHTML: String) -> [BusLocations] {
        return DefaultBusLocationFactory().getLeftBusLocations(with: rawHTML)
    }
    
    func getRightBuses(_ rawHTML: String) -> [BusLocations] {
        return DefaultBusLocationFactory().getRightBusLocations(with: rawHTML)
    }
    
    //MARK: - Get Stops

    func getStops(_ rawHTML: String) -> [Stop] {
        return DefaultBusStopFactory().getStops(with: rawHTML)
    }
}

