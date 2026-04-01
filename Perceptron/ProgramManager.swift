//
//  Model.swift
//  Perceptron
//
//  Created by Viktoriia Savchuk  on 01/04/2026.
//

import Foundation

struct ProgramManager {
    
    func loadData(from fileName: String) -> [Sample] {
            var samples: [Sample] = []

            //get the file path in Documents folder
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent(fileName)

                //debug lines
                guard FileManager.default.fileExists(atPath: fileURL.path) else {
                    print("File does NOT exist: \(fileURL.path)")
                    return samples
                }

                print("File exists: \(fileURL.path)")

                do {
                    let text = try String(contentsOf: fileURL, encoding: .utf8)
                    
                    //normalize line endings, replace all \r\n and \r with \n so every line is separated consistently
                    
                    let normalizedText = text
                        .replacingOccurrences(of: "\r\n", with: "\n")
                        .replacingOccurrences(of: "\r", with: "\n")

                    let lines = normalizedText.split(separator: "\n")

                    for line in lines {
                        let parts = line.split { $0 == " " || $0 == "\t" }

                        guard parts.count >= 2 else { continue }

                        var features: [Double] = []

                        for i in 0..<(parts.count - 1) {
                            let value = parts[i].replacingOccurrences(of: ",", with: ".")
                            if let num = Double(value) {
                                features.append(num)
                            } else {
                                print("Warning: could not parse number '\(parts[i])'")
                            }
                        }

                        var label: Int = 0 //default
                        
                        if let lastPart = parts.last {
                            if lastPart == "iris-setosa" {
                                label = 1
                            } else {
                                label = 0
                            }
                        }
                        
                        let sample = Sample(features: features, label: label)
                        
                        samples.append(sample)
                    }

                } catch {
                    print("Error reading file: \(error)")
                }
            }

            return samples
        }
}
