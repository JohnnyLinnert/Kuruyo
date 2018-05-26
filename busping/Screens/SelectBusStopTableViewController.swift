import Foundation
import UIKit
import BrightFutures

class SelectBusStopTableViewController: UITableViewController {
    private let busStopRepo: BusStopRepository
    private var allStops: [Stop]?
    
    init (busStopRepo: BusStopRepository) {
        self.busStopRepo = busStopRepo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: String(describing: UITableViewCell.self)
        )
        
        busStopRepo.allStops(forLine: "恵32").onSuccess { arrayOfStops in
            self.allStops = arrayOfStops
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Table View Data Source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allStops?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)
        if let stops = allStops {
            cell.textLabel?.text = stops[indexPath.row].name
        }
        return cell
    }
}
