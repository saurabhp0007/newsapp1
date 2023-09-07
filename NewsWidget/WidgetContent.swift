

import Foundation
import SwiftUI
import WidgetKit

struct WidgetContent: TimelineEntry {
    var date: Date
    var title: String
    var description: String?
    var url: Int
  //  var image: UIImage?
    
}

extension WidgetContent {
    
    //Network update
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
