import Foundation

enum APIError: Error {
    case decoding
    case noDataReturned
    case noConnectivity
    case other
    
    static func createFromError(error: Error?, statusCode: StatusCode?) -> APIError {
        if let error = APIError.apiServiceErrorForHTTPStatus(statusCode: statusCode,
                                                             errorCode: (error as NSError?)?.code) {
            return error
        } else {
            return APIError.other
        }
    }
    
    static func apiServiceErrorForHTTPStatus(statusCode: Int?, errorCode: Int?) -> APIError? {
        guard let statusCode = statusCode, 200..<400 ~= statusCode else { return errorForCode(errorCode) }
        return nil
    }
    
    static func errorForCode(_ errorCode: Int?) -> APIError {
        guard let errorCode = errorCode, NSURLErrorBadServerResponse..<NSURLErrorCancelled ~= errorCode else { return .other }
        
        return .noConnectivity
    }
    
    var message: String {
        switch self {
        case .noDataReturned:
            return "Request did not return any data."
        case .noConnectivity:
            return "Connection to the Internet could not be established."
        default:
            return "Some Error occured, please try again later."
        }
    }
}
