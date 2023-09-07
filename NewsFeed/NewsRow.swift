import SwiftUI

struct NewsRow: View {
   
    var article: ViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                
                ZStack(alignment: .topLeading) {
                    if let image = article.image {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        Text(article.title)
                            .lineLimit(nil)
                            .font(.system(size: 15))
                            .foregroundColor(Color.white)
                    }
                  
                }
            
                
                HStack(alignment: .firstTextBaseline) {
                    Text(article.sourceName)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    Spacer()
                    
                    Text(article.publishedAt)
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                    
                }
                .padding(.top)
            }
        }
    }
}


struct NewsRow_Previews: PreviewProvider {
    static var previews: some View {
        NewsRow(article: ListViewModel().articles[0])
            
    }
}

