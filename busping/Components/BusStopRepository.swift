import Foundation
import BrightFutures

protocol BusStopRepository {
    func allStops(forLine line: String) -> Future<[Stop]?, NSError>
}

class TokyuBusStopRepository: BusStopRepository {
    let http: HTTP
    init(http: HTTP) {
        self.http = http
    }
    
    func allStops(forLine line: String) -> Future<[Stop]?, NSError> {
        let promise = Promise<[Stop]?, NSError>()
        let path = "/api/get-stop-list?line=\(line)"
        
        http.get(path).onSuccess { data in
            let decoder = JSONDecoder()
            
            do {
                let stopsDictionary = try decoder.decode(Dictionary<String, Dictionary<String, String>>.self, from: data!)
                
                if let stops = stopsDictionary["stops"] {
                    var allStops = [Stop]()
                    
                    for (_, value) in stops {
                        let stop = Stop(name: value)
                        allStops.append(stop)
                        
                        promise.success(allStops)
                    }
                }
                
            } catch {
                print("error", error)
            }
        }
        
        return promise.future
    }
}



protocol HTTP {
    func get(_ path: String) -> Future<Data?, NSError>
}

class KuruyoHTTP: HTTP {
    let host: String = "kuruyo.cfapps.io"
    
    func get(_ path: String) -> Future<Data?, NSError> {
        let promise = Promise<Data?, NSError>()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        guard let url = urlComponents.url else {fatalError("Could not create a URL from components")}

        URLSession.shared.dataTask(with:url, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let posts = json["posts"] as? [[String: Any]] ?? []
                print(posts)
                promise.success(data)
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
        
//        var request = URLRequest(url:url)
//        request.httpMethod = "GET"
//        var headers = request.allHTTPHeaderFields ?? [:]
//        headers["Content-Type"] = "application/json"
//        request.allHTTPHeaderFields = headers
//
//        let config = URLSessionConfiguration.default
//        let session = URLSession(configuration: config)
//
//        let task = session.dataTask(with: request) { (responseData, response, responseError) in
//            guard responseError == nil else {
//                print("error executing URLSession data task")
//                return
//            }
//
//            if let data = responseData {
//                print("Succesfull request responded with", data)
//                promise.success(data)
//            }
//        }
//
//        task.resume()
//
        return promise.future
    }
}
