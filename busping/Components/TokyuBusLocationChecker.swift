import Foundation
import BrightFutures
import Result

struct TokyuBusLocationChecker {
    func getMoriyaToshokan() -> Future<Stop, NSError> {
        let promise = Promise<Stop, NSError>()
            
        TokyuBusHTMLRepository().getHTML().onSuccess { rawHTML in
            let stops = DefaultBusStopFactory().getStops(with: rawHTML)
            let stop = stops.filter { stop in
                return stop.name == "守屋図書館"
            }
            promise.success(stop[0])
            
        }
        return promise.future
    }
}
