//
//  Map.swift
//  GenE_rz
//
//  Created by Ronald Zambrano on 10/27/20.
//  Copyright © 2020 Group3b. All rights reserved.
//

import SwiftUI

struct Map: View {
    
    @ObservedObject public var dataManager = DataManager.shared
    
    @Binding public var seqId: String
    
    // rz- to pass seqId to second view
 //   @State public var seqId2: String = ""
    
    var body: some View {
        
        ZStack {
            VStack {
                Text("Results").foregroundColor(Color.white).onAppear{self.dataManager.downloadSeqData(seqId: self.seqId)}                        .onAppear(perform: playSound)/*rz want to add this sound func to contentview somehow, otherwise it will constantly play sound when page loads */ .edgesIgnoringSafeArea(.all)
                
                //rz- if strand is linear draw line
                if dataManager.dataSet?.INSDSeq.topology == "linear" {
                    
                Rectangle()
                    .fill(Color.black)
                    .frame(width: 500, height: 20)
                }
                //rz- if strand is circular draw o
                if dataManager.dataSet?.INSDSeq.topology == "circular" {
                Circle()
                    .stroke(Color.black, style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                    .frame(width: 500, height: 500)
                }
                if dataManager.dataSet?.INSDSeq.topology != "circular" && dataManager.dataSet?.INSDSeq.topology != "linear"{
                    Text("Data Unavailable, try a new accession number.")
                }
            }
                
            .navigationBarItems(
//rz - added home and genbank view to navigation bars
                leading:
                    NavigationLink(destination: ContentView()) {
                           Text("New Query")
                               .font(.title)
                               .foregroundColor(Color.black)
                        },

                trailing:
                NavigationLink(destination: Screen(seqId: self.$seqId)) {
                      Text("GenBank View")
                          .font(.title)
                          .foregroundColor(Color.black)
                   }
            )
        }
    }
}

struct Map_Previews: PreviewProvider {
    static var previews: some View {
        Map(seqId: .constant("text"))
    }
}
