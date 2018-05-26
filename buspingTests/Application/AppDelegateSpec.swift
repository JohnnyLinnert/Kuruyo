import Foundation
import Quick
import Nimble

@testable import busping
class AppDelegateSpec: QuickSpec {
    var appDelegate: AppDelegate!
    
    override func spec() {
        
        beforeEach {
            self.appDelegate = AppDelegate()
            let window = UIWindow()
            
            self.appDelegate.window = window
            self.appDelegate.setupInitialViewController()
            window.makeKeyAndVisible()
        }
        
        describe("the App Delegate") {
            it("should display the list of bus lines on load") {
               
                let navCtrl = self.appDelegate.window!.rootViewController as! UINavigationController
                expect(navCtrl.topViewController).to(beAnInstanceOf(SelectBusLineTableViewController.self))
            }
        }
    }
    
    public func testDummy() {}
}
