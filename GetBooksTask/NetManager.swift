import Alamofire

class DataReciever {
    private static let urlString = "https://demo.api-platform.com/books"
    
    static func loadBooks(pageNumber: Int, completion: @escaping (Books?) -> ()){
        doRequest(params: ["page":"\(pageNumber)"], completionHandler: completion)
    }
    
    static func doRequest(params: [String: String],completionHandler: @escaping (Books?) -> ()){
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        AF.request(self.urlString, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers:[HTTPHeader(name:"accept", value:"application/json")]).validate().responseDecodable(of: Books.self, decoder: decoder)
        { responce in
            
            switch responce.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print("Network error: \(error.localizedDescription)")
                }
        }
    }
}
