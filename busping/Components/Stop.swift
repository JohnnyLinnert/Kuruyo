import Foundation
import Gloss

struct Stop: JSONDecodable {
    let name: String

    init(name: String) {
        self.name = name
    }

    init?(json: JSON) {
        guard let name: String = "name" <~~ json else {
            return nil
        }
        self.name = name
    }
}
