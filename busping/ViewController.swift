//  ViewController.swift
//  busping
//
//  Created by Johnny Linnert, beginning on 2016/09/28 
//  With great help from Greg de Jonckheere and Jonathon Toon
//  Copyright © 2017 Johnny Linnert. All rights reserved.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestHTML() { [unowned self] rawMarkup in
            let stops = self.getStops(rawMarkup)

            for stop in stops {
                print(stop.name)
            }

            print()
            print()

            for stop in stops.reversed() {
                print(stop.name)
            }

            print()
            print()

            let buses = self.getBuses(rawMarkup)
            for bus in buses {
                if let stop = bus.leftStop {
                    print(stop.name)
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

    func getBuses(_ rawHTML: String) -> [Bus] {
        var buses = [Bus]()
        if let doc = Kanna.HTML(html: rawHTML, encoding: .utf8) {

            var lastStop: Stop? = nil

            for row in doc.css(".routeListTbl tr").reversed() {

                if row.css(".stopName a").count > 0 {
                    let stopName = row.css(".stopName a")[0].text
                    lastStop = Stop(name: stopName ?? "No name")

                } else if row.css(".balloonL img[src=buslocation/images/PC_00.png]").count > 0 {
                    let bus = Bus(leftStop: lastStop)
                    buses.append(bus)
                }


            }

        }
        return buses
    }


    func getStops(_ rawHTML: String) -> [Stop] {
        var stops = [Stop]()
        if let doc = Kanna.HTML(html: rawHTML, encoding: .utf8) {
            
            for stopRow in doc.css(".routeListTbl .stopName a").reversed() {
                let stop = Stop(name: stopRow.text ?? "No name")
                stops.append(stop)
            }
            
        }
        return stops
    }
    
    
}


struct Bus {
    let leftStop: Stop?
}

struct Stop {
    let name: String
}
