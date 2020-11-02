//
//  datamanager.swift
//  xml_parser
//
//  Created by chris richardson on 10/21/20.
//

import Foundation
import XMLCoder

struct INSDSet: Decodable {
    let INSDSeq: INSDSeq
}

struct INSDSeq: Decodable {
    let locus: String
    let length: Int
    let strandedness: String
    let moltype: String
    let topology: String
    let sequence: String
    let keywords: INSDSeq_Keywords
    let featureTable: INSDSeq_FeatureTable
    let definition: String
    let organism: String
    let taxonomy: String
    let source: String


    private enum CodingKeys: String, CodingKey {
        case locus = "INSDSeq_locus", length = "INSDSeq_length", strandedness = "INSDSeq_strandedness", moltype = "INSDSeq_moltype", sequence = "INSDSeq_sequence", keywords = "INSDSeq_keywords", featureTable = "INSDSeq_feature-table", definition = "INSDSeq_definition", topology = "INSDSeq_topology", organism = "INSDSeq_organism", taxonomy = "INSDSeq_taxonomy", source = "INSDSeq_source"
    }

    init(from decoder: Decoder) throws {
        let container = try! decoder.container(keyedBy: CodingKeys.self)
        self.locus = try! container.decode(String.self, forKey: .locus)
        self.length = try! container.decode(Int.self, forKey: .length)
        self.strandedness = try! container.decode(String.self, forKey: .strandedness)
        self.moltype = try! container.decode(String.self, forKey: .moltype)
        self.sequence = try! container.decode(String.self, forKey: .sequence)
        self.keywords = try! container.decode(INSDSeq_Keywords.self, forKey: .keywords)
        self.featureTable = try! container.decode(INSDSeq_FeatureTable.self, forKey: .featureTable)
        self.definition = try! container.decode(String.self, forKey: .definition)
        self.topology = try! container.decode(String.self, forKey: .topology)
        self.organism = try! container.decode(String.self, forKey: .organism)
        self.taxonomy = try! container.decode(String.self, forKey: .taxonomy)
        self.source = try! container.decode(String.self, forKey: .source)
    }

}

struct INSDSeq_Keywords: Decodable {
    let INSDKeyword: [String]
}

struct INSDSeq_FeatureTable: Decodable {
    let INSDFeature: [INSDFeature]
}

struct INSDFeature: Decodable, Hashable {
    let INSDFeature_key: String
    let INSDFeature_location: String
    let INSDFeature_intervals: [INSDFeature_intervals]
    let INSDFeature_quals: [INSDFeature_quals]

    static func == (lhs: INSDFeature, rhs: INSDFeature) -> Bool {
        lhs.INSDFeature_key == rhs.INSDFeature_key
    }

    func hash(into hasher: inout Hasher) {}
}

struct INSDFeature_intervals: Decodable {
    let INSDInterval: [INSDInterval]
}

struct INSDInterval: Decodable {
    let INSDInterval_from: Int?
    let INSDInterval_to: Int?
    let INSDInterval_point: Int?
    let INSDInterval_accession: String?
}

struct INSDFeature_quals: Decodable {
    let INSDQualifier: [INSDQualifier]
}
struct INSDQualifier: Decodable {
    let INSDQualifier_name: String
    let INSDQualifier_value: String
}


class DataManager: ObservableObject {
    static let shared = DataManager()

    @Published var dataSet: INSDSet?

    @Published var featureList: [INSDFeature] = []


    func downloadSeqData(seqId: String) {
        let urlString = "https://www.ncbi.nlm.nih.gov/sviewer/viewer.cgi?tool=portal&save=file&log$=seqview&db=nuccore&report=gbc_xml&id=\(seqId)&conwithfeat=on&withparts=on&hide-cdd=on"
        let url = URL(string: urlString)!

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }

            guard let data = data else {
                print("invalid data!")
                return
            }

            do {
                let decodedDataSet = try XMLDecoder().decode(INSDSet.self, from: data)
                DispatchQueue.main.async {
                    self.dataSet = decodedDataSet
                    self.featureList = self.dataSet?.INSDSeq.featureTable.INSDFeature ?? []
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}
