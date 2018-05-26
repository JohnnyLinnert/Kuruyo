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
        
        http.get(path, forLine: line).onSuccess { data in
            let decoder = JSONDecoder()

            if let data = data {
                do {
                    let stopsDictionary = try decoder.decode(Array<Dictionary<String, Array<Dictionary<String, String>>>>.self, from: data)

                    var allStops = [Stop]()
                    for stop in stopsDictionary[0]["stops"]! {
                        let name = stop["name"]
                        let newStopObject = Stop(name: name!)
                        allStops.append(newStopObject)
                    }
                    promise.success(allStops)

                } catch {
                    print("error", error)
                }
            }
        }
        
        return promise.future
    }
}
