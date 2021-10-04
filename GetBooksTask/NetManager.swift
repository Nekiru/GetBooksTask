import Foundation

class NetRequester{
    //создание запроса
     static func doRequest(url: URL, completionHandler: @escaping (Result<Data, Error>) -> ()){
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        //чтобы получить данные в нужном формате
        request.addValue("application/json", forHTTPHeaderField: "accept")
        let dataTask = URLSession.shared.dataTask(with: request){data, response, error in
            DispatchQueue.main.async {
                if let error = error{
                    completionHandler(.failure(error))
                }
                guard let data = data else {return}
                completionHandler(.success(data))
            }
        }
        dataTask.resume()
    }
}

class DataReciever {
    static func loadBooks(pageNumber: Int, completion: @escaping (Books?) -> ()){
        NetRequester.doRequest(url: getUrlByPage(pageNumber)){ result in
                switch result
                {
                    case .success(let data):
                        completion(DataDecoder.DecodeData(data: data))
                    case .failure(let error):
                        print("Network error: \(error.localizedDescription)")
                        completion(nil)
                }
        }
    }
    
    private static let urlString = "https://demo.api-platform.com/books"
    
    // url с нужным номером страницы
    private static func getUrlByPage(_ pageNumber: Int) -> URL {
        return buildUrl(urlString, [("page","\(pageNumber)")])
    }
    
    //создание url с заданными параметрами
    private static func buildUrl(_ urlString: String, _ params: [(String,String)]) -> URL
    {
        var urlComponents = URLComponents(string: urlString)
        var paramString = ""
        for p in params{
            if paramString != ""{ paramString += "&"}
            paramString += "\(p.0)=\(p.1)"
        }
        urlComponents?.query = paramString
        return (urlComponents?.url)!
    }
}
