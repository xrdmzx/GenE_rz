import SwiftUI


struct ContentView: View {
    
    @ObservedObject public var dataManager = DataManager.shared
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
                    
                    Group {
                        Text(dataManager.dataSet?.INSDSeq.locus ?? "")
                        Text(dataManager.dataSet?.INSDSeq.organism ?? "")
                        Text(dataManager.dataSet?.INSDSeq.source ?? "")
                        Text(dataManager.dataSet?.INSDSeq.taxonomy ?? "")
                        Text("\(dataManager.dataSet?.INSDSeq.length ?? 0) ")
                        Text(dataManager.dataSet?.INSDSeq.moltype ?? "")
                    }
                    
                    Group {
                        Text(dataManager.dataSet?.INSDSeq.topology ?? "")
                        Text(dataManager.dataSet?.INSDSeq.strandedness ?? "")
                        Text(dataManager.dataSet?.INSDSeq.definition ?? "")
                        Text(dataManager.dataSet?.INSDSeq.featureTable.INSDFeature.map{ $0.INSDFeature_key}.joined(separator: ", \n") ?? "")
                        Text(dataManager.dataSet?.INSDSeq.featureTable.INSDFeature.map{$0.INSDFeature_location}.joined(separator: ", \n") ?? "")
                    }
                    
                    Group {
                    Text(dataManager.dataSet?.INSDSeq.sequence ?? "")
                    }

                    
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
                    
                    // Button
                    Button(action: {
                        
                        playSound()
                        self.dataManager.downloadSeqData(seqId: self.seqId)
                    }) {
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
                         NavigationLink(destination: Text("About View")
                                            ) {
                                Text("About")
                                    .font(.title)
                                    .foregroundColor(Color.white)
                             },
                            
                        
                     trailing:
                         NavigationLink(destination: Text("Help View")) {
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
