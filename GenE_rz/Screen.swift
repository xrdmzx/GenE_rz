
//
//  ContentView.swift
//  xml_parser
//
//  Created by Chris Richardson on 10/21/20.
//

import SwiftUI

struct Screen: View {


    @ObservedObject public var dataManager = DataManager.shared
    @Binding public var seqId: String

    var body: some View {
        VStack {
           TextField("Enter Accession Number", text: $seqId)
            .padding()

        Button("Search") {
            self.dataManager.downloadSeqData(seqId: self.seqId)
               }

            ScrollView {

            VStack(alignment: .leading) {
                VStack(alignment: .leading) {

                    Text(dataManager.dataSet?.INSDSeq.locus ?? "").padding()
                    Text(dataManager.dataSet?.INSDSeq.organism ?? "").padding()
                    Text(dataManager.dataSet?.INSDSeq.source ?? "").padding()
                    Text(dataManager.dataSet?.INSDSeq.taxonomy ?? "").padding()
                    Text("\(dataManager.dataSet?.INSDSeq.length ?? 0) ").padding()
                    Text(dataManager.dataSet?.INSDSeq.strandedness ?? "").padding()
                    Text(dataManager.dataSet?.INSDSeq.moltype ?? "").padding()

                }

                .cornerRadius(10)

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(dataManager.featureList, id:\.self) { feature in

                        VStack {
                            VStack {
                                Text(feature.INSDFeature_key).bold()
                                Text(feature.INSDFeature_location)
                            }.padding()

  //                          IntervalSection(feature: feature)

                            QualsSection(feature: feature)

                        }
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(10)
                    }
                }

                .cornerRadius(20)
            }
            .padding(.horizontal)
        }

        }

        }
}

/*
struct IntervalSection: View {
    var feature: INSDFeature
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<feature.INSDFeature_intervals.count, id: \.self) { i in
                ForEach(0..<feature.INSDFeature_intervals[i].INSDInterval.count, id: \.self) { j in
                    if let from = feature.INSDFeature_intervals[i].INSDInterval[j].INSDInterval_from {
                        VStack {
                            Text("\(from)")
                            Text("\(feature.INSDFeature_intervals[i].INSDInterval[j].INSDInterval_to ?? -1)")
                        }
                        .padding()
                    //    .frame(width: UIScreen.main.bounds.width - 30)
                    //   .background(Color.red.opacity(0.4))
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
}
*/
struct QualsSection: View {
    var feature: INSDFeature
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<feature.INSDFeature_quals.count , id: \.self) { i in
                ForEach(0..<self.feature.INSDFeature_quals[i].INSDQualifier.count , id: \.self) { j in
                    VStack {
                        Text(self.feature.INSDFeature_quals[i].INSDQualifier[j].INSDQualifier_name)
                        Text(self.feature.INSDFeature_quals[i].INSDQualifier[j].INSDQualifier_value)
                    }
                    .padding()
                 //   .frame(width: UIScreen.main.bounds.width - 30)
                //    .background(Color.blue.opacity(0.4))
                    .cornerRadius(10)
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Screen(seqId: .constant("text"))
    }
}

