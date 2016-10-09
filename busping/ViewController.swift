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



        Alamofire.request("http://tokyu.bus-location.jp/blsys/navi?VID=rtl&EID=nt&PRM=&RAMK=116&SCT=1").response { response in
            print("Request: \(response.request)")
            print("Response: \(response.response)")
            print("Error: \(response.data)")

            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
            }

        }




    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
                

        }

    }

