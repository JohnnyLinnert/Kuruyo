import Foundation
import BrightFutures

@testable import busping

class FakeKuruyoHTTP: HTTP {
    func get(_ path: String, forLine busLine: String) -> Future<Data?, NSError> {
        let jsonString = """
                    [
                        {
                            "stops": [
                                {
                                    "name": "恵比寿駅"
                                },
                                {
                                    "name": "下通五丁目"
                                }
                            ]
                        }
                    ]
                """
        let fakeData = try! JSONSerialization.data(withJSONObject: jsonString.toJSON()!, options: .prettyPrinted)
        let fakePromise = Promise<Data?, NSError>()
        fakePromise.success(fakeData)
        return fakePromise.future
    }
}
