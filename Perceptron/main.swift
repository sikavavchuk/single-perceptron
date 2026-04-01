//
//  main.swift
//  Perceptron
//
//  Created by Viktoriia Savchuk  on 01/04/2026.
//

import Foundation

var perceptron = Perceptron()
var programManager = ProgramManager()
var userAnswer: String?
var userSample: [Double] = [0, 0, 0, 0]

let trainingData = programManager.loadData(from: "iris_training.txt")
let testData = programManager.loadData(from: "iris_test.txt")

perceptron.trainDataset(trainingData)

perceptron.test(testData)

let accuracy = Double(perceptron.correctPredictions) / Double(testData.count)

print("Accuracy: \(accuracy * 100)%")

while userAnswer == nil {
    print("Print parameters to test the model:")
    for i in 0..<4 {
        print("Parameter \(i + 1): ")
        let input = readLine()!
        if let number = Double(input) {
            userSample[i] = number
        } else {
            print("Please enter a valid number")
            break
        }
    }
    print(userSample)
    
    let prediction = perceptron.predict(userSample)
    
    print("The predicted species is: \(prediction)")
}
