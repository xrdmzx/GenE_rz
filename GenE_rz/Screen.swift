//  ContentView.swift
//  XML_Parser_SwiftUI
//
//  Created by Chris Richardson on 10/6/20.
//

import SwiftUI

struct Screen: View {
    

    @ObservedObject public var dataManager = DataManager.shared
    
    @Binding public var seqId: String

    var body: some View {
        ScrollView {
            ZStack {
/* // rz- commented out because i think background is laeving a gap at the top of the top of page
                // Background navy blue
                Rectangle()
                    .foregroundColor(Color(red: 10/255, green: 77/255, blue: 174/255)).edgesIgnoringSafeArea(.all)
 */
                VStack(alignment:.leading) {
                    //rz- this essentially replaces the former "Search" button (also plays sound) https://stackoverflow.com/questions/58883501/swiftui-calling-functions-from-other-class
                    Text("Results").foregroundColor(Color.white).onAppear{self.dataManager.downloadSeqData(seqId: self.seqId)}.edgesIgnoringSafeArea(.all)
                    
                    Group {
                        Text(dataManager.dataSet?.INSDSeq.locus ?? "")
                        Text(dataManager.dataSet?.INSDSeq.organism ?? "")
                        Text(dataManager.dataSet?.INSDSeq.source ?? "")
                        Text(dataManager.dataSet?.INSDSeq.taxonomy ?? "")
                        Text("\(dataManager.dataSet?.INSDSeq.length ?? 0) ")
                        Text(dataManager.dataSet?.INSDSeq.moltype ?? "")
                    }.foregroundColor(Color.black)
                    
                    Group {
                        Text(dataManager.dataSet?.INSDSeq.topology ?? "")
                        Text(dataManager.dataSet?.INSDSeq.strandedness ?? "")
                        Text(dataManager.dataSet?.INSDSeq.definition ?? "")
                        Text(dataManager.dataSet?.INSDSeq.featureTable.INSDFeature.map{ $0.INSDFeature_key}.joined(separator: ", \n") ?? "")
                        Text(dataManager.dataSet?.INSDSeq.featureTable.INSDFeature.map{$0.INSDFeature_location}.joined(separator: ", \n") ?? "")
                    }.foregroundColor(Color.black)
                    
                    Group {
                        Text(dataManager.dataSet?.INSDSeq.sequence ?? "")
                    }.foregroundColor(Color.black)
                }
            }
        }.frame(maxWidth: .infinity) //rz - allow for scrolling data by tapping anywhere on screen
    }
}

struct Screen_Previews: PreviewProvider {
    static var previews: some View {
        //rz- still not sure what the parameters in Screen() are for, but it allowed me to run my code without crashing... https://stackoverflow.com/questions/58701826/swiftui-how-to-instantiate-previewprovider-when-view-requires-binding-in-initia
        Screen(seqId: .constant("text"))
    }
}
