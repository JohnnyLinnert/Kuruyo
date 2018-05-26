import UIKit

extension UIViewController {
    func setupForUnitTesting() {
        view.setNeedsLayout()
    }

    func hasLabel(withText searchText: String) -> Bool {
        return view.hasLabel(withText: searchText)
    }

    func containsView(withBackgroundColor searchColor: UIColor) -> Bool {
        return view.containsView(withBackgroundColor: searchColor)
    }
}

extension UIView {
    func hasLabel(withText searchText: String) -> Bool {

        if let tableView = self as? UITableView {
            let numberOfSections = tableView.numberOfSections
            for section in 0..<numberOfSections {
                let numberOfRows = tableView.numberOfRows(inSection: section)
                for item in 0..<numberOfRows {
                    let indexPath = IndexPath(item: item, section: section)
                    if let cell = tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) {
                        if (cell.subviews.count) > 0 {
                            if (cell.hasLabel(withText: searchText)) {
                                return true
                            }
                        }
                    }
                }
            }
        }

        for subview in subviews {
            if let label = subview as? UILabel {
                if label.text == searchText {
                    return true
                }
            }

            if let collectionView = subview as? UICollectionView {
                let numberOfSections = collectionView.numberOfSections
                for section in 0..<numberOfSections {
                    let numberOfItems = collectionView.numberOfItems(inSection: section)
                    for item in 0..<numberOfItems {
                        let indexPath = IndexPath(item: item, section: section)
                        if let cell = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) {
                            if (cell.subviews.count) > 0 {
                                if (cell.hasLabel(withText: searchText)) {
                                    return true
                                }
                            }
                        }
                    }
                }
            }

            if subview.subviews.count > 0 {
                if subview.hasLabel(withText: searchText) {
                    return true
                }
            }
        }

        return false
    }

    func containsView(withBackgroundColor searchColor: UIColor) -> Bool {
        for subview in subviews {
            if subview.backgroundColor == searchColor {
                return true
            }

            if let collectionView = subview as? UICollectionView {
                let numberOfSections = collectionView.numberOfSections
                for section in 0..<numberOfSections {
                    let numberOfItems = collectionView.numberOfItems(inSection: section)
                    for item in 0..<numberOfItems {
                        let indexPath = IndexPath(item: item, section: section)
                        if let cell = collectionView.dataSource?.collectionView(collectionView, cellForItemAt: indexPath) {
                            if cell.backgroundColor == searchColor {
                                return true
                            }

                            if (cell.subviews.count) > 0 {
                                if (cell.containsView(withBackgroundColor: searchColor)) {
                                    return true
                                }
                            }
                        }
                    }
                }
            }

            if subview.subviews.count > 0 {
                if (subview.containsView(withBackgroundColor: searchColor)) {
                    return true
                }
            }
        }

        return false
    }
}
