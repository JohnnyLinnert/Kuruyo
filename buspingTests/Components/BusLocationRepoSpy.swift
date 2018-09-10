import Foundation
import BrightFutures

@testable import busping

class BusLocationRepoSpy: BusLocationRepository {

    var closestBusLocation_fromStop: Stop!
    var closestBusLocation_toStop: Stop!
    var closestBusLocation_line: String!
    var closestBusLocation_returnValue: Future<CurrentBusLocation?, NSError>!
    func closestBusLocation(fromStop: Stop, toStop: Stop, line: String) -> Future<CurrentBusLocation?, NSError> {
        closestBusLocation_fromStop = fromStop
        closestBusLocation_toStop = toStop
        closestBusLocation_line = line
        return closestBusLocation_returnValue
    }
}
