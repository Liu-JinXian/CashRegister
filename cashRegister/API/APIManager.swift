//
//  APIManager.swift
//  cashRegister
//
//  Created by 劉晉賢 on 2021/8/8.
//

import RxSwift
import Alamofire
import Reachability
import CoreLocation
import RxCocoa

class APIManager: NSObject {
    static let shared = APIManager()
    let reachability = Reachability()!
    
    var isReachable = Variable(true)
    
    private var progress:Progress!
    private var context = 0
    
    lazy var requestManager: SessionManager = {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = APITimeout
        config.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        
        return SessionManager(configuration: config)
    }()
    
    override init() {
        super.init()
        
        let reachabilityManager = NetworkReachabilityManager.init(host:"www.apple.com")
        let isInternetReachable = (reachabilityManager?.isReachable) ?? false
        
        self.isReachable.value = isInternetReachable
        reachability.whenUnreachable = { reachability in
            DispatchQueue.main.async {
                self.isReachable.value = false
            }
        }
        
        reachability.whenReachable = { reachability in
            DispatchQueue.main.async {
                self.isReachable.value = true
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            #if DEBUG
            print("Error")
            #endif
        }
    }
    
    deinit {
        progress.removeObserver(self, forKeyPath: "apiCompleted")
    }
    
    fileprivate func manager(method: HTTPMethod, appendUrl: String, url: APIUrl, parameters: [String: Any]?, appendHeaders: [String: String]?) -> Single<[String:Any]> {
        
        return Single.create { (single) -> Disposable in
            
            let param = (parameters) ?? [String:Any]()
            let requestUrl: String = self.getRequestUrlWith(url: url, appendUrl: appendUrl)
            let encode: ParameterEncoding = self.getEncodeWith(method: method)
            
            self.printRequest(requestUrl,param)
            
            if (self.isReachable.value == false) {
                let err = APIError.init(type: .noInternetException, localDesc: "The Internet connection appears to be offline.", alertMsg: "")
                return Disposables.create()
            }
            
            self.requestManager
                .request(requestUrl, method: method, parameters: param, encoding: encode)
                .validate()
                .responseJSON(completionHandler: { (response) in
                    switch response.result {
                    case .success(let value):
                        if (value is [String:Any]) {
                            self.printResponse(requestUrl, value)
                            single(.success(value as! [String:Any]))
                        } else {
                            let err = APIError.init(type: .otherException, localDesc: "It's success.But AlertMsg doesn't exist.", alertMsg: "")
                            self.printErrorResponse(requestUrl, response, err, alertMsg: "")
                        }
 
                    case .failure(let error):
                        
                        var json: [String : String] = [:]
                        
                        if let data = response.data {
                            do{
                                json = try (JSONSerialization.jsonObject(with: data, options: []) as! [String: String])
                            }catch{
                                json["AlertMsg"] = ""
                            }
                        }
                        
                        let alertMsg = json["AlertMsg"] ?? ""
                        
                        self.printErrorResponse(requestUrl, response, error, alertMsg: alertMsg)
                        
                        let localDesc = (error as NSError).localizedDescription
                        let errorCode = (error as NSError).code
                        let statusCode = response.response?.statusCode ?? nil
                        let err: APIError = APIError(statusCode: statusCode, errorCode: errorCode, localDesc: localDesc, alertMsg: alertMsg)
                    }
                })
            return Disposables.create()
        }
    }
    
    private func getEncodeWith(method: HTTPMethod) -> ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
          
        case .post:
            return JSONEncoding.default
            
        default:
            return URLEncoding.default
        }
    }
    
    private func getRequestUrlWith(url: APIUrl, appendUrl: String) -> String {
        let encodeUrl = appendUrl
        var requestUrl = ""
        
        switch url {
        case .authApi(let type):
            requestUrl = type.url()
        }

        requestUrl =  (requestUrl + encodeUrl ).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return requestUrl
    }
    
    func cancelAllRequest () {
        self.printLog(value: "cancel All Request")
        requestManager.session.getTasksWithCompletionHandler {
            (sessionDataTask, uploadData, downloadData) in
            sessionDataTask.forEach { $0.cancel() }
            uploadData.forEach { $0.cancel() }
            downloadData.forEach { $0.cancel() }
        }
    }
}

extension APIManager {
    
    private func printRequest(_ requestUrl: String, _ params: [String: Any]) {
        //return
        #if DEBUG
        print("-------------------------------------------------------")
        print("* 【呼叫】 The_requestUrl : \(requestUrl)")
        print("* 【呼叫】 Request_params : ")
        print(params)
        print(getPrettyParams(params) ?? "")
        #endif
    }
    
    private func printResponse(_ requestUrl: String,_ value: (Any)) {
        //return
        #if DEBUG
        print("-------------------------------------------------------")
        print("* 【回應】 The_requestUrl : \(requestUrl)")
        print("* 【回應】 Response_value : ")
        print(getPrettyPrint(value))
        #endif
    }
    
    private func printErrorResponse(_ requestUrl:String, _ response: (DataResponse<Any>), _ error: (Error), alertMsg: String) {
        //return
        #if DEBUG
        print("-------------------------------------------------------")
        print("* 【回應錯誤】 The_requestUrl : \(requestUrl)")
        print("* StatusCode : \(String(describing: response.response?.statusCode))")
        print("* View_OnError : \(String(describing:error))")
        print("* Error.code : \((error as NSError).code)")
        print("* AlertMsg : \(alertMsg)")
        #endif
    }
    
    private func printLog(value:String){
        #if DEBUG
        print("-------------------------------------------------------")
        print("****** \(value) ******")
        print("****** \(value) ******")
        print("****** \(value) ******")
        print("-------------------------------------------------------")
        #endif
    }
    
    private func getPrettyPrint(_ responseValue: Any) -> String {
        var string: String = ""
        if let data = try? JSONSerialization.data(withJSONObject: responseValue, options: .prettyPrinted) {
            if let nstr = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                string = nstr as String
            }
        }
        return string
    }
    
    private func getPrettyParams(_ dict: [String: Any]) -> NSString? {
        let jsonData = try! JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
    }
}
