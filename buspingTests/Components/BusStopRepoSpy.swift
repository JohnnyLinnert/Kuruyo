import Foundation
import BrightFutures

@testable import busping

class BusStopRepoSpy: BusStopRepository {

    var allStops_lineArg: String!
    var allStops_returnValue: Future<[Stop]?, NSError>!
    func allStops(forLine line: String) -> Future<[Stop]?, NSError> {
        return allStops_returnValue
    }

}
