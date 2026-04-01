//
//  Perceptron.swift
//  Perceptron
//
//  Created by Viktoriia Savchuk  on 01/04/2026.
//

import Foundation

struct Perceptron {
    var weights: [Double] = [Double.random(in: -1...1), Double.random(in: -1...1), Double.random(in: -1...1), Double.random(in: -1...1)]
    var threshold: Double = 0
    var parameterAlfa: Double = 0.1
    var correctPredictions: Int = 0
    
    func predict(_ input: [Double]) -> Int {
        
        var net: Double = 0
        
        for i in 0..<4 {
            net = net + weights[i] * input[i]
        }
        
        print("Raw score:", net)
    
        
        if net >= threshold {
            return 1
        } else {
            return 0
        }
    }
    
    mutating func trainDataset(_ dataset: [([Double], Int)]) {
    
        var epoch = 0
        var hasError = true
        
        while hasError {
            hasError = false
            epoch += 1
            
            for (input, expectedOutput) in dataset {
                            
                let prediction = predict(input)
                            
                let error = expectedOutput - prediction
             
                if error != 0 {
                    hasError = true
                    
                    for i in 0..<weights.count {
                        weights[i] += parameterAlfa * Double(error) * input[i]
                    }
                    
                    threshold -= parameterAlfa * Double(error)
                }
            }
            
            print("Epoch: \(epoch) completed.")
        }
        
        print("Training finished in \(epoch) epochs.")
    }
    
    mutating func test(_ dataset: [([Double], Int)]) {
        for (input, expectedOutput) in dataset {
            let prediction = predict(input)
            print("Prediction: \(prediction), expected: \(expectedOutput)")
            if prediction == expectedOutput {
                correctPredictions += 1
                print("Correct")
            }
        }
        
    }
}
