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
    @IBAction func sendNotification(_ sender: Any) {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "kuruyo.cfapps.io"
        urlComponents.path = "/api/request-notification"
        guard let url = urlComponents.url else {fatalError("Could not create a URL from components")}
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        let encoder = JSONEncoder()
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let token = appDel.token!
        do {
            let body = NotificationPost(
                targetStop: "守屋図書館",
                stopsAway: 3,
                deviceToken: token
            )
            let jsonData = try encoder.encode(body)
            request.httpBody = jsonData
        } catch {
            print("failed to encode body as JSON object")
        }

        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) { (responseData, response, responseError) in
            guard responseError == nil else {
                print("error executing URLSession data task")
                return
            }
            
            if let data = responseData {
                print("Succesfull request responded with", data)
            }
        }
        
        task.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

struct NotificationPost: Codable {
    let targetStop: String
    let stopsAway: Int
    let deviceToken: String
}
