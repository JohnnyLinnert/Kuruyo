import Foundation
import UIKit

protocol Router {
    var rootViewController: UINavigationController? { get set }
    func showRootViewController()
    func showBusStopTableViewController()
    func showRouteDetailScreen(fromStop: Stop, toStop: Stop, line: String)
}

class NavigationRouter: Router {
    var rootViewController: UINavigationController?
    
    func showRootViewController() {
        let viewCtrl = SelectBusLineTableViewController(router: self)
        let navCtrl = UINavigationController()
        navCtrl.setViewControllers([viewCtrl], animated: true)
        rootViewController = navCtrl
    }
    
    func showBusStopTableViewController() {
        let http = KuruyoHTTP()
        let repo = TokyuBusStopRepository(http: http)
        let newTableViewCtrl = SelectBusStopTableViewController(router: self, busStopRepo: repo)
        rootViewController?.pushViewController(
            newTableViewCtrl,
            animated: true
        )
    }

    func showRouteDetailScreen(fromStop: Stop, toStop: Stop, line: String) {
        let http = KuruyoHTTP()
        let busLocationRepo = TokyuBusLocationRepository(http: http)
        let reloader = AutomaticReloader()
        let routeDetailViewCtrl = RouteDetailViewController(
            busLocationRepo: busLocationRepo,
            fromStop: fromStop,
            toStop: toStop,
            automaticReloader: reloader
        )
        
        rootViewController?.pushViewController(routeDetailViewCtrl, animated: true)
    }
}
