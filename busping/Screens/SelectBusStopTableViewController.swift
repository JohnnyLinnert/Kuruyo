import Foundation
import UIKit
import BrightFutures

class SelectBusStopTableViewController: UITableViewController {
    private let busStopRepo: BusStopRepository
    private var allStops: [Stop]?
    private var startingLocationIndexPath: IndexPath?
    private var destinationIndexPath: IndexPath?
    
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
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: String(describing: UITableViewCell.self))
        
        if let stops = allStops {
            cell.textLabel?.text = stops[indexPath.row].name
        }
        
        if  let startingIndexPath = startingLocationIndexPath,
            indexPath == startingIndexPath {
            cell.detailTextLabel?.text = "Starting Location"
        }
        
        if  let destinationIndexPath = destinationIndexPath,
            indexPath == destinationIndexPath {
            cell.detailTextLabel?.text = "Destination"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == startingLocationIndexPath {
            startingLocationIndexPath = nil
            tableView.reloadData()
            return
        }
        
        if indexPath == destinationIndexPath {
            destinationIndexPath = nil
            tableView.reloadData()
            return
        }
        
        if startingLocationIndexPath != nil {
            destinationIndexPath = indexPath
        } else {
            startingLocationIndexPath = indexPath
        }
        
        tableView.reloadData()
    }
}
