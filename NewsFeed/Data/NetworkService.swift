
import Foundation
import UIKit
class NetworkService {
    
    static func loadData(completion: @escaping ([Article]?) -> ()) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=in&apiKey=7c67e28d8f514efd9ea038d20a32c323"
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data, error == nil {
                
                let response = try? JSONDecoder().decode(JSONModel.self, from: data)
                if let response = response {
                    DispatchQueue.main.async {
                        completion(response.articles)
                    }
                }
            } else {
                print("Error in: \(#function)")
                completion(nil)
            }
        }
        task.resume()
        
    }
    
}

final class ImageStore {

    static func downloadImageBy(url: String, completion: @escaping (UIImage)->Void) {
        
        guard let url = URL(string: url) else {
            print("failed to produce URL for image")
            return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
                } else {
                    print("failed to get Image from data")
                }
            } else {
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                if data == nil {
                    print("no data for Image")
                }
            }
        }
        task.resume()
    }
}
