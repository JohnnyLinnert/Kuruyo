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
        let path = "/api/get-stop-list"
        
        http.get(path, line).onSuccess { data in
            let decoder = JSONDecoder()
            
            do {
                let stopsDictionary = try decoder.decode(Array<Dictionary<String, Array<Dictionary<String, String>>>>.self, from: data!)

                var allStops = [Stop]()
                for stop in stopsDictionary[0]["stops"]! {
                    let name = stop["name"]
                    let newStopObject = Stop(name: name!)
                    allStops.append(newStopObject)
                }
                promise.success(allStops)

            } catch {
                print("error", error)
                print("data", String(data: data!, encoding: .utf8)!)
            }
        }
        
        return promise.future
    }
}



protocol HTTP {
    func get(_ path: String, _ line: String) -> Future<Data?, NSError>
}

class KuruyoHTTP: HTTP {
    let host: String = "kuruyo.cfapps.io"
    
    func get(_ path: String, _ line: String) -> Future<Data?, NSError> {
        let promise = Promise<Data?, NSError>()
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        urlComponents.queryItems = [URLQueryItem(name: "line", value: line)]
        guard let url = urlComponents.url else {fatalError("Could not create a URL from components")}

        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if let data = data {
                promise.success(data)
            }
        })
        task.resume()

        return promise.future
    }
}

