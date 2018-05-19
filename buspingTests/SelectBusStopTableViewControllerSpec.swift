import Foundation
import Quick
import Nimble
import BrightFutures

@testable import busping
class SelectBusStopTableViewControllerSpec: QuickSpec {
    var fakeKuruyoHTTP: FakeKuruyoHTTP!
    var busStopRepository: BusStopRepository!
    var vc: SelectBusStopTableViewController!
    
    func createViewController() {
        vc = SelectBusStopTableViewController(busStopRepo: busStopRepository)
    }
    
    override func spec() {
        
        beforeEach {
            self.fakeKuruyoHTTP = FakeKuruyoHTTP()
            self.busStopRepository = TokyuBusStopRepository(http: self.fakeKuruyoHTTP)
        }
        
        describe("the BusStopTableViewController") {
            it("should display a list of bus stops") {
                let json = [
                    "stops": [
                        "name": "恵比寿駅"
                    ]
                ]
                let fakeData = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                let fakePromise = Promise<Data?, NSError>()
                self.fakeKuruyoHTTP.get_path_returnValue = fakePromise.future
                fakePromise.success(fakeData)
                
                self.createViewController()
                
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = self.vc.tableView(self.vc.tableView, cellForRowAt: indexPath)
                expect(cell.textLabel?.text).to(equal("恵比寿駅"))
            }
        }
    }
}
