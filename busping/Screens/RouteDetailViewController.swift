import Foundation
import UIKit

class RouteDetailViewController: UIViewController {
    private let busLocationRepo: BusLocationRepository
    private var label: UILabel!
    private let fromStop: Stop
    private let toStop: Stop
    private let reloader: Reloader

    init(busLocationRepo: BusLocationRepository, fromStop: Stop, toStop: Stop, automaticReloader: Reloader) {
        self.busLocationRepo = busLocationRepo
        self.fromStop = fromStop
        self.toStop = toStop
        self.reloader = automaticReloader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        view.addSubview(label)

        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            label.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor),
            label.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor)
        ])

        refreshBusLocation()
    }

    override func viewDidAppear(_ animated: Bool) {
        reloader.performOnRepeat(withInterval: 15) {
            self.refreshBusLocation()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        reloader.cancelAutomaticReload()
    }

    private func refreshBusLocation() {
        busLocationRepo.closestBusLocation(fromStop: fromStop, toStop: toStop, line: "恵32").onSuccess { location in
            if let currentLocation = location {
                self.label.text = "The next bus is currently at \(currentLocation.stop.name) which is \(currentLocation.numberAway) stops away."
            }
        }
    }
}
