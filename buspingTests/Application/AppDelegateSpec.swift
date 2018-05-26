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
            context("when I open the app") {
                it("should display the list of bus lines") {

                    let navCtrl = self.appDelegate.window!.rootViewController as! UINavigationController
                    expect(navCtrl.topViewController).to(beAnInstanceOf(SelectBusLineTableViewController.self))
                }
            }
        }
    }
}
