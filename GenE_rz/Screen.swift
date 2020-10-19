//  ContentView.swift
//  XML_Parser_SwiftUI
//
//  Created by Chris Richardson on 10/6/20.
//

import SwiftUI

struct ChrisView: View {

    @ObservedObject public var dataManager = DataManager.shared
    
    @State public var seqId: String = ""

    var body: some View {
        
        VStack {
            
            TextField("Enter Accession Number", text: $seqId).padding()
            
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

            Button("Search") {
                self.dataManager.downloadSeqData(seqId: self.seqId)
            }
 
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChrisView()
    }
}
