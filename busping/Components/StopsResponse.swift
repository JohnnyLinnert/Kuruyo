import Foundation

struct StopsResponse: Decodable {
    let stops: [Stop]

    enum CodingKeys: String, CodingKey {
        case stops = "stops"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        do {
            let stopsJson = try values.decode([[String: String]].self, forKey: .stops)
            if let allStops = [Stop].from(jsonArray: stopsJson) {
                stops = allStops
            } else {
                stops = []
            }
        }
    }
}
