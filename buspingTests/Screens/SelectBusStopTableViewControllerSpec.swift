import Foundation
import Quick
import Nimble
import BrightFutures

@testable import busping
class SelectBusStopTableViewControllerSpec: QuickSpec {
    var fakeKuruyoHTTP: FakeKuruyoHTTP!
    var busStopRepository: BusStopRepository!
    var routerSpy: NavigationRouterSpy!
    var vc: SelectBusStopTableViewController!
    
    func createViewController() {
        routerSpy = NavigationRouterSpy()
        vc = SelectBusStopTableViewController(router: routerSpy, busStopRepo: busStopRepository)
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
                

                expect(self.vc.hasLabel(withText: "Starting Location")).toEventually(beTrue())
            }
            
            it("should display destination stop") {
                self.createViewController()
                
                
                self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
                

                expect(self.vc.hasLabel(withText: "Destination")).toEventually(beTrue())
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

        describe("navigation bar") {
            it("should navigate to the route detail screen when next is tapped") {
                self.createViewController()

                waitUntil { done in
                    self.busStopRepository.allStops(forLine: "恵32").onSuccess(callback: { stops in
                        expect(self.vc.allStops).toNot(beNil())

                        self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
                        self.vc.tableView(self.vc.tableView, didSelectRowAt: IndexPath(row: 1, section: 0))
                        self.vc.perform(self.vc.navigationItem.rightBarButtonItem!.action)

                        expect(self.routerSpy.showRouteDetailScreen_lineArg).to(equal("恵32"))
                        expect(self.routerSpy.showRouteDetailScreen_toStopArg.name).to(equal("下通五丁目"))
                        expect(self.routerSpy.showRouteDetailScreen_fromStopArg.name).to(equal("恵比寿駅"))

                        done()
                    })
                }
            }
        }
    }
}
