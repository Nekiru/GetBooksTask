import Alamofire

class DataReciever {
    private static let urlString = "https://demo.api-platform.com/books"
    
    static func loadBooks(pageNumber: Int, completion: @escaping (Books?) -> ()){
        doRequest(params: ["page":"\(pageNumber)"], completionHandler: completion)
    }
    
    static func doRequest(params: [String: String],completionHandler: @escaping (Books?) -> ()){
        AF.request(self.urlString, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers:[HTTPHeader(name:"accept", value:"application/json")]).validate().responseData
        { responce in
            
            switch responce.result {
                case .success(let value):
                    completionHandler(DataDecoder.DecodeData(data: value))
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                }
        }
    }
}
