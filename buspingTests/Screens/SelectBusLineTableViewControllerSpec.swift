import Nimble
import Quick

@testable import busping
class SelectBusLineTableViewControllerSpec: QuickSpec {
    var vc: SelectBusLineTableViewController!
    var routerSpy: NavigationRouterSpy!
    
    override func spec() {
        
        beforeEach {
            self.routerSpy = NavigationRouterSpy()
            self.vc = SelectBusLineTableViewController(router: self.routerSpy)
        }
        
        describe("The select bus line table view ctrl") {
            it("should display 1 bus line") {
                expect(self.vc.hasLabel(withText: "恵32")).to(beTrue())
            }
            
            context("when the user selects a bus line") {
                it("should display the bus stops for that line") {
                    self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))

                    expect(self.routerSpy.showBusStopTableViewControllerWasCalled).to(beTrue())
                }
            }
        }
    }
}
