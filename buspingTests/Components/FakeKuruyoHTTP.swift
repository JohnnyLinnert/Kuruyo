import Foundation
import BrightFutures

@testable import busping

class FakeKuruyoHTTP: HTTP {
    var jsonString: String!
    func get(_ path: String, withQuery queries: [String : String]) -> Future<Data?, NSError> {
        let fakeData = try! JSONSerialization.data(withJSONObject: jsonString.toJSON()!, options: .prettyPrinted)
        let fakePromise = Promise<Data?, NSError>()
        fakePromise.success(fakeData)
        return fakePromise.future
    }

    func get(_ path: String, forLine busLine: String) -> Future<Data?, NSError> {
        let fakeData = try! JSONSerialization.data(withJSONObject: jsonString.toJSON()!, options: .prettyPrinted)
        let fakePromise = Promise<Data?, NSError>()
        fakePromise.success(fakeData)
        return fakePromise.future
    }
}

struct FakeJSONFixture {
    static func stopsReponse() -> String {
        return """
        [{
            "stops": [
                {
                    "name": "恵比寿駅"
                },
                {
                    "name": "下通五丁目"
                }
            ]
        }]
        """
    }

    static func busLocationsResponse() -> String {
        return """
        {
            "currentBusLocation": {
                "busLocation": "恵比寿駅",
                "stopsAway": "3"
            }
        }
        """
    }
}
