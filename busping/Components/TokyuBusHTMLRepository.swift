import Foundation
import Alamofire
import BrightFutures
import Result

protocol HTMLRepository {
    func getHTML() -> Future<String, NSError>
}

struct TokyuBusHTMLRepository: HTMLRepository {
    func getHTML() -> Future<String, NSError>{
        let promise = Promise<String, NSError>()
        
        Alamofire.request("http://tokyu.bus-location.jp/blsys/navi?VID=rtl&EID=nt&PRM=&RAMK=116&SCT=1").response { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                promise.success(utf8Text)
            }
        }
        
        return promise.future
    }
}
