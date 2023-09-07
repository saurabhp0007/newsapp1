

import SwiftUI

struct ContentView : View {
    
    //observable model
    @StateObject var model: ListViewModel = ListViewModel()
    
    //deeplink received from widget will trigger this values
    @State var linkActive: Bool = false
    @State var value: Int = 0
    
    var body: some View {
         NavigationView {
             List(model.articles) { article in
                 if linkActive {
                     NavigationLink(destination: NewsDetailed(article: model.articles[value]), isActive: $linkActive) {
                         NewsRow(article: article)
                     }
                 } else {
                     NavigationLink(destination: NewsDetailed(article: article)) {
                         NewsRow(article: article)
                     }
                 }
             }
             .navigationBarTitleDisplayMode(.inline)
             .navigationBarItems(leading: CustomTitleView())
             .background(Color.white)
             .onOpenURL { url in
                 linkActive = true
                 value = Int(url.lastPathComponent)!
                 print(url.lastPathComponent)
                 print("Received deep link: \(url)")
             }
         }
     }
 }

 struct CustomTitleView: View {
     var body: some View {
         VStack {
             Spacer()
             Text("HEADLINES")
                 .font(.headline)
                 .foregroundColor(.white)
                 .padding(.top, 8) // Adjust the top padding as needed
             Spacer()
         }
         .frame(alignment: .leading)
     }
 }
    
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()//(model: ArticleListViewModel())
    }
}
extension UINavigationController {
    
    override open func viewDidLoad() { super.viewDidLoad()
        
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = .black
        
        navigationBar.standardAppearance = appearance
    }
    
}

