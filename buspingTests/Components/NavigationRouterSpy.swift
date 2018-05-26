import Foundation
import UIKit

@testable import busping

class NavigationRouterSpy: Router {
    var rootViewController: UINavigationController?
    
    var showRootViewControllerWasCalled = false
    func showRootViewController() {
        showRootViewControllerWasCalled = true
    }
    
    var showBusStopTableViewControllerWasCalled = false
    func showBusStopTableViewController() {
        showBusStopTableViewControllerWasCalled = true
    }
}
