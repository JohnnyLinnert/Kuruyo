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

    override func viewDidLoad() {
        super.viewDidLoad()
        requestHTML() { [unowned self] rawMarkup in
            let stops = self.getStops(rawMarkup)

            for stop in stops.reversed() {
                print(stop.name)
            }

            print()
            print()

            let buses = self.getLeftBuses(rawMarkup)
            for bus in buses {
                if let stop = bus.stop {
                    print("Left Buses leaving", stop.name)
                } else {
                    print("Idling bus")
                }
            }
            
            let rightbuses = self.getRightBuses(rawMarkup)
            for bus in rightbuses {
                if let stop = bus.stop {
                    print("Right Buses leaving", stop.name)
                } else {
                    print("Idling bus")
                }
                }
            }
        }

    func requestHTML(completed: @escaping (String) -> ()) {
        Alamofire.request("http://tokyu.bus-location.jp/blsys/navi?VID=rtl&EID=nt&PRM=&RAMK=116&SCT=1").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                completed(utf8Text)
            }
        }
    }
    
    //MARK: - Get Busses

    func getLeftBuses(_ rawHTML: String) -> [Bus] {
        var leftBuses = [Bus]()
        
        do {
            let doc = try Kanna.HTML(html: rawHTML, encoding: .utf8)

            var lastStop: Stop? = nil
            
            for row in doc.css(".routeListTbl tr").reversed() {
                
                if row.css(".stopName a").count > 0 {
                    let stopName = row.css(".stopName a")[0].text
                    lastStop = Stop(name: stopName ?? "No name")
                }
                    
                else if row.css(".balloonL img[src=buslocation/images/PC_00.png]").count > 0 {
                    let leftBus = Bus(stop: lastStop)
                    leftBuses.append(leftBus)
                }
            }
        } catch {
            print("Failed to get LeftBuses from raw HTML", error)
        }
        
        return leftBuses
    }
    
    func getRightBuses(_ rawHTML: String) -> [Bus] {
        var rightBuses = [Bus]()
        do {
            let doc = try Kanna.HTML(html: rawHTML, encoding: .utf8)
            var lastStop: Stop? = nil
        
            for row in doc.css(".routeListTbl tr") {
                
                if row.css(".stopName a").count > 0 {
                    let stopName = row.css(".stopName a")[0].text
                    lastStop = Stop(name: stopName ?? "No name")
                }
                else if row.css(".balloonR img[src=buslocation/images/PC_00.png]").count > 0 {
                    let rightBus = Bus(stop: lastStop)
                    rightBuses.append(rightBus)
                }
            }
            
        } catch {
            print("Failed to get RightBuses from raw HTML", error)
        }
        
        return rightBuses
    }
    
    //MARK: - Get Stops

    func getStops(_ rawHTML: String) -> [Stop] {
        var stops = [Stop]()
        
        do {
            let doc = try Kanna.HTML(html: rawHTML, encoding: .utf8)
            
            for stopRow in doc.css(".routeListTbl .stopName a").reversed() {
                let stop = Stop(name: stopRow.text ?? "No name")
                stops.append(stop)
            }
        } catch {
            print("Failed to get stops from raw HTML")
        }
        return stops
    }
    
    
}

struct Bus {
    let stop: Stop?
}

struct Stop {
    let name: String
}
