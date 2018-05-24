import Foundation
import BrightFutures

@testable import busping

class FakeKuruyoHTTP: HTTP {
    var get_path_arg: String!
    var get_path_returnValue: Future<Data?, NSError>!
    func get(_ path: String, _ line: String) -> Future<Data?, NSError> {
        get_path_arg = path
        return get_path_returnValue
    }
}
