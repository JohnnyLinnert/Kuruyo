import Foundation
import BrightFutures

protocol BusLocationRepository {
    func closestBusLocation(fromStop: Stop, toStop: Stop, line: String) -> Future<CurrentBusLocation?, NSError>
}

class TokyuBusLocationRepository: BusLocationRepository {
    let http: HTTP
    init(http: HTTP) {
        self.http = http
    }

    func closestBusLocation(
        fromStop: Stop,
        toStop: Stop,
        line: String
    ) -> Future<CurrentBusLocation?, NSError> {
        let promise = Promise<CurrentBusLocation?, NSError>()
        let path = "/api/closest-bus"

        http.get(path, withQuery: ["fromStop": fromStop.name, "toStop": toStop.name, "line": line]).onSuccess { data in
            let decoder = JSONDecoder()

            if let data = data {
                do {
                    let busLocationResponse = try decoder.decode(ClosestBusLocationResponse.self, from: data)
                    if let busLocation = busLocationResponse.currentBusLocation {
                        promise.success(busLocation)
                    } else {
                        promise.failure(NSError(domain: "Current Bus Location is Empty", code: 0, userInfo: nil))
                    }
                } catch {
                    print("error", error)
                }
            }
        }

        return promise.future
    }
}
