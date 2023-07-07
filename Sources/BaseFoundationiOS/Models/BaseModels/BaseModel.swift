//
//  BaseModel.swift
//
//
//  Created by pablo borquez on 07/07/23.
//

import Foundation

open class BaseModel {
    open var endPointManager: EndPointManager = EndPointManager()

    open func getRESTApiModel() -> BaseRESTAPIModel {
        return BaseRESTAPIModel()
    }
    
    open func validate(completionResult: CompletionResult) throws {
        if let success: Bool = try completionResult.convertData(), success == false {
            throw BaseLocalizables.internalServerError
        }
    }
    
    open func set(id: String?, to url: String) -> String {
        var url = url

        if let id = id {
            url = String(format: url, id)
        }

        return url
    }
}
