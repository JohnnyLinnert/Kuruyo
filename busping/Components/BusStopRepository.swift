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
                    let stopsResponse = try decoder.decode([StopsResponse].self, from: data)
                    promise.success(stopsResponse[0].stops)
                } catch {
                    print("error", error)
                }
            }
        }
        
        return promise.future
    }
}
