// Jacob about page https://github.com/Jacobvazquez18/GenE_UPDATED/blob/main/About
import SwiftUI

struct About: View {
    var body: some View {
        ScrollView{
            ZStack {
                
                // Background navy blue
                Rectangle()
                    .foregroundColor(Color(red: 10/255, green: 77/255, blue: 174/255))
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    AboutImage()
                        .offset(x: 0, y: -10)
                        .edgesIgnoringSafeArea(.all)
                    Spacer()
                    
                    Text("About")
                    
                    Spacer()
                    
                    Text("We are a group of 5 biotechnology students. GenE started as a capstrone project and evolved to much more. Our company found that with our app development skills and programming skills, we could change the face of genetic retrieval and editing capacity.")
                        .foregroundColor(Color.white)
                        .padding()
                        .font(.system(size: 25))
                        .font(.title)
                        .offset(x: 0, y: -49)
                        .fixedSize(horizontal: false, vertical: true)
                        
                    
                    Text("About")
                        .font(.system(size: 50))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .offset(x: 0, y: -260)
                    
                    HStack {
                        ScienceImage1()
                            .offset(x: 0, y: -130)
                        ScienceImage2()
                            .offset(x: 0, y: -130)
                    }
                    
                    Text("What Sets Us Apart?")
                        .font(.system(size: 50))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .offset(x: 0, y: -115)
                    
                    Text("Being that our product is available in the IOS platform, our technology is user friendly and not stationary. Through chemical reactions, molecules are ever changing, so why settle for stagment technology?")
                        .fontWeight(.regular)
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .font(.system(size: 25))
                        .font(.title)
                        .offset(x: 0, y: -125)
                        .fixedSize(horizontal: false, vertical: true)
                    
                }
            }
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}

