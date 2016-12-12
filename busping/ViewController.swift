//
//  ViewController.swift
//  busping
//
//  Created by Johnny on 2016/09/28.
//  Copyright © 2016 Johnny Linnert. All rights reserved.
//

import UIKit
import Alamofire
import Kanna


class ViewController: UIViewController, UITableViewDelegate {



    override func viewDidLoad() {
        super.viewDidLoad()

         getBusInfo()

    }

    func getBusInfo () -> Void {

        Alamofire.request("http://tokyu.bus-location.jp/blsys/navi?VID=rtl&EID=nt&PRM=&RAMK=116&SCT=1").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.data)")

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print(utf8Text)
                self.cleanBusInfo(html: utf8Text)
            }
        }
    }

    func cleanBusInfo (html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: .utf8) {

            // *** Perhaps will have to combine the two following loops so all instances of busActual and busStop are sequential. This is key to understanding the positioning of the bus in reference to the stop, and will ultimately allow us to report the live location of the bus. ***

//            for busActual in doc.css("tr > td.balloonL > dl > dt > img") {
//                                print(busActual["alt"])
//
//                            }

            // Okay, trying to get parent tr (table row) class for each img found. Thus far I've confirmed that at least I'm going down the right path. Though my output is nil, there are 4 nil elements printing, which is exactly the same number of buses on the

//            for busIcon in doc.css("td.balloonL > dl > dt > img") {
//                print(busIcon.content)
//            }

// This line only gets me the busIcon, but no significant useful data otherwise (e.g. which row is it on?)
            for busToXML in doc.css("td.balloonL > dl > dt > img") {
                print(busToXML.toXML)
            }


            for stuff in doc.xpath("//*[@id=\"SubmitForm\"]/table[1]/tbody/tr[5]/td[1]/dl/dt/img") {
                print(stuff.parent)
            }


// Using the innerHTML of the class seems to pull out a solid list of strings here
            for busStop in doc.css("td.stopName > a") {
                print(busStop.innerHTML)
            }

//             for busStops in doc.css("tr") {
//                print(busStops.toXML)
//            }

        }




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
                

        }

    }

