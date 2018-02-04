import Foundation
import Kanna

struct DefaultBusStopFactory {
    func getStops(with html: String) -> [Stop] {
        var stops = [Stop]()
        
        do {
            let doc = try Kanna.HTML(html: html, encoding: .utf8)
            
            for stopRow in doc.css(".routeListTbl .stopName a").reversed() {
                let stop = Stop(name: stopRow.text ?? "No name")
                stops.append(stop)
            }
        } catch {
            print("Failed to get stops from raw HTML")
        }
        return stops
    }
}
