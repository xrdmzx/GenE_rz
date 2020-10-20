import SwiftUI


struct ContentView: View {
    
    @State public var seqId: String = ""
    
  
    var body: some View {
        
        NavigationView {
            ZStack {
                
                // Background navy blue
                Rectangle()
                    .foregroundColor(Color(red: 10/255, green: 77/255, blue: 174/255)).edgesIgnoringSafeArea(.all)
                
                // Background light blue
                Rectangle()
                    .foregroundColor(Color(red: 86/255, green: 118/255, blue: 255/255))
                    .frame(height: 300)
                    .offset(x: 0, y: -250)
                
                VStack {
                    
                    // Image of Logo
                    Logo()
                        .offset(x: 0, y: -90)
                    
                    // Text for user input
                    Text("Please enter the gene accession number below")
                        .font(.system(size: 45))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .offset(x: -50, y: -10)
                    
                    // Text field for user input Ω£
                    TextField("NG_017013", text: $seqId)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .offset(x: 0, y: -8)
                        .font(.system(size: 40))
                    
                    // Button (Navigationlink) to go to Chris results view
                    NavigationLink(destination: Screen(seqId: self.$seqId)){
                        Text("Find my sequence! 🧬")
                            .font(.system(size: 40))
                            .foregroundColor(Color.white)
                            .bold()
                            .padding(.all, 10)
                            .background(Color(red: 86/255, green: 118/255, blue: 255/255))
                            .cornerRadius(20)
                            .offset(x: 0, y: 50)
                    }.padding()
                }.padding()
                
                .navigationBarItems(
                     leading:
                         NavigationLink(destination: About()) {
                                Text("About")
                                    .font(.title)
                                    .foregroundColor(Color.white)
                             },
                            
                        
                     trailing:
                         NavigationLink(destination: Help()) {
                            Text("Help")
                                .font(.title)
                                .foregroundColor(Color.white)
                         }
                 )
                
                
                
            }
           
          
        }
        
        
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
    

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }

        }
