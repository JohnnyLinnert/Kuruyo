import Foundation
import BrightFutures
import Result

struct TokyuBusLocationChecker {
    func checkIfBusIsThreeStopsAway(at stop: Stop, busLocations: [BusLocations]) -> Bool {
        for busLocation in busLocations {
            if stop.name == busLocation.stop?.name {
                return true
            }
        }
        
        return false
    }
}
