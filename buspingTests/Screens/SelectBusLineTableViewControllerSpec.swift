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
            let _ = UINavigationController(rootViewController: self.vc)
            self.vc.view.setNeedsLayout()
            self.vc.viewDidLoad()
            self.vc.viewDidAppear(false)
        }
        
        describe("The select bus line table view ctrl") {
            it("should display 1 bus line") {
                let indexPath = IndexPath(row: 0, section: 0)
                let cell = self.vc.tableView(self.vc.tableView, cellForRowAt: indexPath)
                
                
                expect(cell.textLabel?.text).to(equal("恵32"))
            }
            
            context("when the user selects a bus line") {
                
                it("should display the bus stop table view ctrl for that line") {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.vc.tableView(self.vc.tableView, didSelectRowAt: indexPath)
                    
                    
                    expect(self.routerSpy.showBusStopTableViewControllerWasCalled).to(beTrue())
                }
            }
        }
    }
}
