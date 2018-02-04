import Foundation
import Kanna

struct DefaultBusLocationFactory {
    func getLeftBusLocations(with html: String) -> [BusLocations] {
        var leftBuses = [BusLocations]()
        
        do {
            let doc = try Kanna.HTML(html: html, encoding: .utf8)
            
            var lastStop: Stop? = nil
            
            for row in doc.css(".routeListTbl tr").reversed() {
                
                if row.css(".stopName a").count > 0 {
                    let stopName = row.css(".stopName a")[0].text
                    lastStop = Stop(name: stopName ?? "No name")
                }
                    
                else if row.css(".balloonL img[src=buslocation/images/PC_00.png]").count > 0 {
                    let leftBus = BusLocations(stop: lastStop)
                    leftBuses.append(leftBus)
                }
            }
        } catch {
            print("Failed to get LeftBuses from raw HTML", error)
        }
        return leftBuses
    }
    
    func getRightBusLocations(with html: String) -> [BusLocations] {
        var rightBuses = [BusLocations]()
        do {
            let doc = try Kanna.HTML(html: html, encoding: .utf8)
            var lastStop: Stop? = nil
            
            for row in doc.css(".routeListTbl tr") {
                
                if row.css(".stopName a").count > 0 {
                    let stopName = row.css(".stopName a")[0].text
                    lastStop = Stop(name: stopName ?? "No name")
                }
                else if row.css(".balloonR img[src=buslocation/images/PC_00.png]").count > 0 {
                    let rightBus = BusLocations(stop: lastStop)
                    rightBuses.append(rightBus)
                }
            }
            
        } catch {
            print("Failed to get RightBuses from raw HTML", error)
        }
        
        return rightBuses
    }
}
