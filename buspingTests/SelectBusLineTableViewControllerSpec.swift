import Nimble
import Quick

@testable import busping
class SelectBusLineTableViewControllerSpec: QuickSpec {
    var vc: SelectBusLineTableViewController!
    
    override func spec() {
        
        beforeEach {
            self.vc = SelectBusLineTableViewController()
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
        }
        
    }
}


