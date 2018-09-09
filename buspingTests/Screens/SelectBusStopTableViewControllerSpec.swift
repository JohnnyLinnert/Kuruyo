import Foundation
import Quick
import Nimble
import BrightFutures

@testable import busping
class SelectBusStopTableViewControllerSpec: QuickSpec {
    var fakeKuruyoHTTP: FakeKuruyoHTTP!
    var busStopRepository: BusStopRepository!
    var vc: SelectBusStopTableViewController!
    
    func createViewController() {
        vc = SelectBusStopTableViewController(busStopRepo: busStopRepository)
        vc.viewDidLoad()
    }
    
    override func spec() {
        
        beforeEach {
            self.fakeKuruyoHTTP = FakeKuruyoHTTP()
            self.busStopRepository = TokyuBusStopRepository(http: self.fakeKuruyoHTTP)
        }
        
        describe("the select bus stop tableview controller") {
            context("when I arrive on the screen") {
                it("should display a list of bus stops") {
                    self.createViewController()

                    expect(self.vc.hasLabel(withText: "恵比寿駅")).toEventually(beTrue())
                }
            }
        }
        
        describe("selecting a to and from stop") {
            it("should display starting stop") {
                self.createViewController()
                
                
                self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                
                
                let cell = self.vc.tableView(self.vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                expect(cell.detailTextLabel?.text).to(equal("Starting Location"))
            }
            
            it("should display destination stop") {
                self.createViewController()
                
                
                self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
                
                
                let cell = self.vc.tableView(self.vc.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
                expect(cell.detailTextLabel?.text).to(equal("Destination"))
            }
            
            context("when I tap on a selected stop again") {
                it("should no longer display the starting stop") {
                    self.createViewController()
                    
                    
                    self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    
                    
                    let cell = self.vc.tableView(self.vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                    expect(cell.detailTextLabel?.text).to(beNil())
                }
                
                it("should no longer display the destination stop") {
                    self.createViewController()
                    
                    
                    self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                    self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
                    self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
                    
                    
                    let cell = self.vc.tableView(self.vc.tableView, cellForRowAt: IndexPath(row: 1, section: 0))
                    expect(cell.detailTextLabel?.text).to(beNil())
                }
            }
        }
    }
}
