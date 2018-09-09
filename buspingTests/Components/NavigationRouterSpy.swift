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

    var showRouteDetailScreen_fromStopArg: Stop!
    var showRouteDetailScreen_toStopArg: Stop!
    var showRouteDetailScreen_lineArg: String!
    func showRouteDetailScreen(fromStop: Stop, toStop: Stop, line: String) {
        showRouteDetailScreen_fromStopArg = fromStop
        showRouteDetailScreen_toStopArg = toStop
        showRouteDetailScreen_lineArg = line
    }
}
