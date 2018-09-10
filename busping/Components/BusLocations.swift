import Foundation
import Gloss

struct BusLocations {
    let stop: Stop?
}

struct CurrentBusLocation: JSONDecodable {
    let stop: Stop
    let numberAway: Int

    init(stop: Stop, numberAway: Int) {
        self.stop = stop
        self.numberAway = numberAway
    }

    init?(json: JSON) {
        guard let stopName: String = "busLocation" <~~ json else {
            return nil
        }

        guard let numberAway: String = "stopsAway" <~~ json else {
            return nil
        }

        self.stop = Stop(name: stopName)
        self.numberAway = Int(numberAway)!
    }
}
