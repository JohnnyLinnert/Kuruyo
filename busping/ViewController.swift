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

//            for busActual in doc.css("tr > td.balloonL > dl > dt > img") {
//                if busActual["alt"] == "バス" {
//                    print("bus")}
//                else {
//                   print("no bus")}
//            }

            for busList in doc.css("tr.trEven > td.balloonL") {
//                print(busList.innerHTML)

                if busList.innerHTML == "\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t<dl class=\"clearfix\">\n\t\t\t\t\t\t\t\t\t<dt><img src=\"buslocation/images/PC_00.png\" style=\"max-width:40px; max-height:30px;\" alt=\"バス\"></dt>\n\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t\t\t<dd>恵比寿駅行 <em></em>\n</dd>\n\t\t\t\t\t\t\t\t\t\n\t\t\t\t\t\t\t\t</dl>\n\t\t\t\t\t\t\t\n\t\t\t\t\t\t" {
                    print("bus")}
                else {
                    print("no bus")}
            }





//            for busIcon in doc.css("td.balloonL > dl > dt > img") {
//                print(busIcon.content)
//            }
//            for busStop in doc.css("td.stopName > a") {
//                print(busStop.innerHTML)
//            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
