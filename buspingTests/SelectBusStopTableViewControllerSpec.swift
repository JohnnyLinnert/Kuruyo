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
        vc.viewDidLoad()
    }
    
    override func spec() {
        
        beforeEach {
            self.fakeKuruyoHTTP = FakeKuruyoHTTP()
            self.busStopRepository = TokyuBusStopRepository(http: self.fakeKuruyoHTTP)
        }
        
        describe("the BusStopTableViewController") {
            it("should display a list of bus stops") {
                self.createViewController()

                expect(self.vc.allStops).toEventuallyNot(beNil())
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = self.vc.tableView(self.vc.tableView, cellForRowAt: indexPath)
                expect(cell.textLabel?.text).toEventually(equal("恵比寿駅"))
            }
        }
    }
}

extension String {
    func toJSON() -> Any? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    }
}
