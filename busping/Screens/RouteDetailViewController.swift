import Foundation
import UIKit

class RouteDetailViewController: UIViewController {
    private let busLocationRepo: BusLocationRepository
    private var label: UILabel!
    private let fromStop: Stop
    private let toStop: Stop

    init(busLocationRepo: BusLocationRepository, fromStop: Stop, toStop: Stop) {
        self.busLocationRepo = busLocationRepo
        self.fromStop = fromStop
        self.toStop = toStop
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
        busLocationRepo.closestBusLocation(fromStop: fromStop, toStop: toStop, line: "恵32").onSuccess { location in
            if let currentLocation = location {
                self.label.text = "The next bus is currently at \(currentLocation.stop.name) which is \(currentLocation.numberAway) stops away."
            }
        }
    }
}
