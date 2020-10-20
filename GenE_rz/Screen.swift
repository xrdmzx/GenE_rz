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
        
        VStack {
            // this essentially replaces the former "Search" button (also plays sound)
            Text("Results").onAppear{self.dataManager.downloadSeqData(seqId: self.seqId)}.onAppear(perform: playSound)
            
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
        }
    }
}

struct Screen_Previews: PreviewProvider {
    static var previews: some View {
        // still not sure what the parameters in Screen() are for, but it allowed me to run my code without crashing... https://stackoverflow.com/questions/58701826/swiftui-how-to-instantiate-previewprovider-when-view-requires-binding-in-initia
        Screen(seqId: .constant("text"))
    }
}
