import Foundation
import Kanna

struct DefaultBusStopFactory {
    func getStops(with html: String) -> [Stop] {
        var stops = [Stop]()
        
        do {
            let doc = try Kanna.HTML(html: html, encoding: .utf8)
            
            for stopRow in doc.css(".routeListTbl .stopName a") {
                let stop = Stop(name: stopRow.text ?? "No name")
                stops.append(stop)
            }
        } catch {
            print("Failed to get stops from raw HTML")
        }
        return stops
    }
    
    // MARK: - Get Specific Stops
    
    func findStop(named stopName: String, with html: String) -> [Stop] {
        let stops = getStops(with: html)
        return stops.filter { stop in
            return stop.name == stopName
        }
    }
    
    func findStopByScanningDown(stopsAway: Int, from stopName: String, with html: String) -> Stop? {
        let stops = getStops(with: html)
        
        if let i = stops.index(where: { stop -> Bool in
            return stop.name == stopName
        }) {
            let stopXStopsAway = stops[i + 3]
            return stopXStopsAway
        }
        
        return nil
    }
}
