//
//  BaseRESTAPIModel.swift
//  
//
//  Created by pablo borquez on 30/06/23.
//

import Foundation
import Alamofire

open class BaseRESTAPIModel: BaseService, CompletionResultDelegate {
    private struct APIManager {
        static let sharedManager: Alamofire.Session = {
            let configuration = URLSessionConfiguration.default
            let settingsController = AppConfiguration.shared.settingsControllerType.init()
            let timeoutKey = BaseSettingsController.BaseKey.timeOutIntervalForRequest.rawValue
            let httpMaxKey = BaseSettingsController.BaseKey.httpMaximumConnectionsPerHost.rawValue
            
            configuration.timeoutIntervalForRequest = settingsController.getSettingNumber(for: timeoutKey).doubleValue
            configuration.httpMaximumConnectionsPerHost = settingsController.getSettingNumber(for: httpMaxKey).intValue
            
            return Alamofire.Session(configuration: configuration)
        }()
    }

    public var addInternalServerChainError: Bool = true
    public var afterCompletion: (() -> Void)?
    public var anyObjectPassed: Any?
    public var addManuallyCancellation: Bool = false
    
    public var printRawResponse: Bool

    public var processId: String?

    private var session: Request?

    private var suspendNotification: NSObjectProtocol?
    private var resumeNotification: NSObjectProtocol?
    private var cancelNotification: NSObjectProtocol?
    
    override public init() {
        let settingsController = AppConfiguration.shared.settingsControllerType.init()
        let printRawKey = BaseSettingsController.BaseKey.printRawResponse.rawValue

        self.printRawResponse = settingsController.getSettingBool(for: printRawKey)
        
        super.init()
    }

    func apiKeySecretDictionaryForRESTAPI() -> [String: String] {
        return [String: String]()
    }

    func get(url: String,
             urlParameters: [String: String]? = nil,
             headers: [String: String]? = nil,
             chainResponse: [RESTAPIChainResponse.Type],
             completionHandler: @escaping CompletionHandler) {
        if let request: DataRequest = self.performRequest(url: url,
                                                          method: .get,
                                                          urlParameters: urlParameters,
                                                          parameters: nil,
                                                          encoding: URLEncoding.queryString,
                                                          headers: headers,
                                                          finalChainResponse: chainResponse,
                                                          completionHandler: completionHandler) {
            if self.addManuallyCancellation {
                self.session = request
            }

            self.handleInterruptions(request: request)
        }
    }
    
    func get(url: String,
             urlParameters: [String: String]? = nil,
             headers: [String: String]? = nil,
             chainResponse: [RESTAPIChainResponse.Type]) async throws -> CompletionResult {
        return try await withCheckedThrowingContinuation { (continuation: CompletionResultCheckedContinuation) in
            self.get(url: url,
                     urlParameters: urlParameters,
                     headers: headers,
                     chainResponse: chainResponse,
                     completionHandler: self.prepare(continuation: continuation))
        }
    }

    func post(url: String,
              urlParameters: [String: String]? = nil,
              bodyParameters: [String: Any]?,
              headers: [String: String]? = nil,
              encoding: RESTAPIEncoding,
              chainResponse: [RESTAPIChainResponse.Type],
              completionHandler: @escaping CompletionHandler) {
        if let request: DataRequest = self.performRequest(url: url,
                                                          method: .post,
                                                          urlParameters: urlParameters,
                                                          parameters: bodyParameters,
                                                          encoding: encoding.getAlamofireEncoding(),
                                                          headers: headers,
                                                          finalChainResponse: chainResponse,
                                                          completionHandler: completionHandler) {
            self.handleInterruptions(request: request)
        }
    }
    
    @discardableResult
    func post(url: String,
              urlParameters: [String: String]? = nil,
              bodyParameters: [String: Any]?,
              headers: [String: String]? = nil,
              encoding: RESTAPIEncoding,
              chainResponse: [RESTAPIChainResponse.Type]) async throws -> CompletionResult {
        return try await withCheckedThrowingContinuation { (continuation: CompletionResultCheckedContinuation) in
            self.post(url: url,
                      urlParameters: urlParameters,
                      bodyParameters: bodyParameters,
                      headers: headers,
                      encoding: encoding,
                      chainResponse: chainResponse,
                      completionHandler: self.prepare(continuation: continuation))
        }
    }

    func put(url: String,
             urlParameters: [String: String]? = nil,
             bodyParameters: [String: Any]?,
             headers: [String: String]? = nil,
             encoding: RESTAPIEncoding,
             chainResponse: [RESTAPIChainResponse.Type],
             completionHandler: @escaping CompletionHandler) {
        if let request: DataRequest = self.performRequest(url: url,
                                                          method: .put,
                                                          urlParameters: urlParameters,
                                                          parameters: bodyParameters,
                                                          encoding: encoding.getAlamofireEncoding(),
                                                          headers: headers,
                                                          finalChainResponse: chainResponse,
                                                          completionHandler: completionHandler) {
            self.handleInterruptions(request: request)
        }
    }

    func delete(_ url: String,
                urlParameters: [String: String]? = nil,
                headers: [String: String]? = nil,
                chainResponse: [RESTAPIChainResponse.Type],
                completionHandler: @escaping CompletionHandler) {
        if let request: DataRequest = self.performRequest(url: url,
                                                          method: .delete,
                                                          urlParameters: urlParameters,
                                                          parameters: nil,
                                                          encoding: URLEncoding.queryString,
                                                          headers: headers,
                                                          finalChainResponse: chainResponse,
                                                          completionHandler: completionHandler) {
            self.handleInterruptions(request: request)
        }
    }
    
    @discardableResult
    func delete(_ url: String,
                urlParameters: [String: String]? = nil,
                headers: [String: String]? = nil,
                chainResponse: [RESTAPIChainResponse.Type]) async throws -> CompletionResult {
        return try await withCheckedThrowingContinuation { (continuation: CompletionResultCheckedContinuation) in
            self.delete(url,
                        urlParameters: urlParameters,
                        headers: headers,
                        chainResponse: chainResponse,
                        completionHandler: self.prepare(continuation: continuation))
        }
    }
 
    func performRequest(url: String,
                        method: CoreHTTPMethod,
                        urlParameters: [String: String]?,
                        parameters: [String: Any]?,
                        encoding: ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil,
                        finalChainResponse: [RESTAPIChainResponse.Type],
                        completionHandler: @escaping CompletionHandler) -> DataRequest? {
        guard let urlTuple = self.prepare(url: url,
                                          urlParameters: urlParameters,
                                          headers: headers,
                                          completionHandler: completionHandler) else {
            return nil
        }
        
        let request = APIManager.sharedManager.request(urlTuple.url,
                                                       method: method.getAlamofireValue(),
                                                       parameters: parameters,
                                                       encoding: encoding,
                                                       headers: urlTuple.headers)
        
        self.logRequest(method: method.getRawValue(),
                        url: url,
                        bodyParameters: parameters,
                        headers: urlTuple.headers)
        
        return request.responseData { response in
            self.responseDataHandler(response: response,
                                     requestName: method.getAlamofireValue().rawValue,
                                     finalChainResponse: finalChainResponse,
                                     completionHandler: completionHandler)
        }
    }
    
    func responseDataHandler(response: AFDataResponse<Data>,
                             requestName: String,
                             finalChainResponse: [RESTAPIChainResponse.Type],
                             completionHandler: CompletionHandler) {
        guard (response.error as NSError?)?.code != NSURLErrorCancelled else {
            return
        }

        #if DEBUG
        Logger.shared?.printBaseRESTAPI("\(requestName) Request completed")
        
        if let response = response.response {
            if let url = response.url {
                Logger.shared?.printBaseRESTAPI("URL: \(url)")
            }
            
            Logger.shared?.printBaseRESTAPI("Http code: \((response.statusCode))")
        }
        #endif
        
        let chainResponses: [RESTAPIChainResponse.Type] = self.prepareChainResponse(chainResponse: finalChainResponse)
        self.prepareFinishedRequest()

        if let chain: RESTAPIChainResponse = RESTAPIChainResponse.create(chain: chainResponses,
                                                                         with: self.anyObjectPassed,
                                                                         processId: self.processId) {
            chain.afterCompletion = self.afterCompletion
            chain.anyObjectPassed = self.anyObjectPassed

            let apiResponse = response.toAPIResponse(printRawResponse: self.printRawResponse)
            let handled: Bool = chain.handle(response: apiResponse,
                                             completionHandler: completionHandler)

            #if DEBUG
            Logger.shared?.printBaseRESTAPI("\(requestName) request handled: \(handled)")
            #endif
        }
    }

    func responseJSONHandler(response: DataResponse<Any, AFError>,
                             requestName: String,
                             finalChainResponse: [RESTAPIChainResponse.Type],
                             completionHandler: CompletionHandler) {
        guard (response.error as NSError?)?.code != NSURLErrorCancelled else {
            return
        }

        let chainResponses: [RESTAPIChainResponse.Type] = self.prepareChainResponse(chainResponse: finalChainResponse)

        #if DEBUG
        Logger.shared?.printBaseRESTAPI("\(requestName) Request completed")

        if let dict = response.value as? [String: Any] {
            Logger.shared?.printBaseRESTAPI("REST Response: \(dict.toJSONText())")
        } else if let array = response.value as? [[String: Any]] {
            Logger.shared?.printBaseRESTAPI("REST Response: \(array.toJSONText())")
        } else {
            Logger.shared?.printBaseRESTAPI("REST Response: \(response)")
        }

        if self.printRawResponse, let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
            Logger.shared?.printBaseRESTAPI("Raw response: \(utf8Text)")
        }

        if response.response != nil {
            Logger.shared?.printBaseRESTAPI("Http code: \((response.response?.statusCode)!)")
        }
        #endif

        self.prepareFinishedRequest()

        if let chain: RESTAPIChainResponse = RESTAPIChainResponse.create(chain: chainResponses,
                                                                         with: self.anyObjectPassed,
                                                                         processId: self.processId) {
            chain.afterCompletion = self.afterCompletion
            chain.anyObjectPassed = self.anyObjectPassed

            let handled: Bool = chain.handle(response: response.toAPIResponse(printRawResponse: self.printRawResponse),
                                             completionHandler: completionHandler)

            #if DEBUG
            Logger.shared?.printBaseRESTAPI("\(requestName) request handled: \(handled)")
            #endif
        }
    }

    // MARK: - request preparations

    private func prepareChainResponse(chainResponse: [RESTAPIChainResponse.Type]) -> [RESTAPIChainResponse.Type] {
        var finalChainResponse: [RESTAPIChainResponse.Type] = chainResponse

        finalChainResponse.insert(NilResponseChainResponse.self, at: 0)
        finalChainResponse.append(BadRequestChainResponse.self)
        finalChainResponse.append(UnauthorizedChainResponse.self)
        finalChainResponse.append(ForbiddenChainResponse.self)
        finalChainResponse.append(NotFoundChainResponse.self)

        if self.addInternalServerChainError {
            finalChainResponse.append(InternalServerErrorChainResponse.self)
        }

        finalChainResponse.append(UnknownChainResponse.self)

        return finalChainResponse
    }

    // MARK: - handle interruptions

    func handleInterruptions(request: Request) {
        self.onSuspendSessionDataTask(session: request)
        self.onResumeSessionDataTask(session: request)
        self.onCancelSessionDataTask(session: request)
    }

    private func onSuspendSessionDataTask(session: Request) {
        self.suspendNotification = NotificationCenter.addNotificationForNameOnMainQueue(BaseNotificationKeys.suspendApplication) { _ in
            session.suspend()
        }
    }

    private func onResumeSessionDataTask(session: Request) {
        self.resumeNotification = NotificationCenter.addNotificationForNameOnMainQueue(BaseNotificationKeys.resumeApplication) { _ in
            session.resume()
        }
    }

    private func onCancelSessionDataTask(session: Request) {
        self.cancelNotification = NotificationCenter.addNotificationForNameOnMainQueue(BaseNotificationKeys.cancelApplication) { _ in
            session.cancel()
        }
    }

    private func removeInternetObservers() {
        if let suspendNotification = self.suspendNotification {
            NotificationCenter.removeObserverNotification(suspendNotification)
        }
        if let resumeNotification = self.resumeNotification {
            NotificationCenter.removeObserverNotification(resumeNotification)
        }

        if let cancelNotification = self.cancelNotification {
            NotificationCenter.removeObserverNotification(cancelNotification)
        }

        self.suspendNotification = nil
        self.resumeNotification = nil
        self.cancelNotification = nil
    }

    // MARK: - handlers

    func prepareFinishedRequest() {
        self.removeInternetObservers()
    }

    private func logRequest(method: String, url: String, bodyParameters: [String: Any]?, headers: HTTPHeaders?) {
        #if DEBUG
        Logger.shared?.printBaseRESTAPI("-------------------- REQUEST --------------------")
        Logger.shared?.printBaseRESTAPI(String(format: "\(method): %@", url))

        if let headers = headers {
            Logger.shared?.printBaseRESTAPI(String(format: "HEADERS: %@", headers.dictionary.toJSONText()))
        }

        if let bodyParameters: [String: Any] = bodyParameters {
            Logger.shared?.printBaseRESTAPI("BODY PARAMETERS: \(bodyParameters.toJSONText())")
        }

        #endif
    }
    
    private func prepare(url: String,
                         urlParameters: [String: String]? = nil,
                         headers: [String: String]? = nil,
                         completionHandler: CompletionHandler) -> (url: String, headers: HTTPHeaders?)? {
        var apiKeySecretDictionary: [String: String] = self.apiKeySecretDictionaryForRESTAPI()
     
        if let urlParameters = urlParameters {
            apiKeySecretDictionary.update(urlParameters)
        }
        
        let urlToRequest: URL? = URL(string: url)?.appendQuery(parameters: apiKeySecretDictionary)
        let httpHeaders: HTTPHeaders? = self.createHeaderForRequest(userHeaders: headers)

        guard let urlConvertible = urlToRequest?.absoluteString else {
            completionHandler(false, BaseLocalizables.internalServerError, nil)
            return nil
        }
        
        return (url: urlConvertible, headers: httpHeaders)
    }
}
