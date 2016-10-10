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
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {

//            for busIcon in doc.css("td.balloonL > dl > dt > img") {
//                print(busIcon["src"])
//            }
//            for busStop in doc.css("td.stopName > a") {
//                print(busStop.text)
//            }

            for busStop in doc.css("tr") {
                print(busStop.className)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
                

        }

    }

