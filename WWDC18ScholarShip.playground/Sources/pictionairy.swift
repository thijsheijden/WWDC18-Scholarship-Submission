//
// pictionairy.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class pictionairyInput : MLFeatureProvider {

    /// image (120x120) as color (kCVPixelFormatType_32BGRA) image buffer, 120 pixels wide by 120 pixels high
    var image__120x120_: CVPixelBuffer
    
    var featureNames: Set<String> {
        get {
            return ["image (120x120)"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "image (120x120)") {
            return MLFeatureValue(pixelBuffer: image__120x120_)
        }
        return nil
    }
    
    init(image__120x120_: CVPixelBuffer) {
        self.image__120x120_ = image__120x120_
    }
}


/// Model Prediction Output Type
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class pictionairyOutput : MLFeatureProvider {

    /// prediction as dictionary of strings to doubles
    let prediction: [String : Double]

    /// classLabel as string value
    let classLabel: String
    
    var featureNames: Set<String> {
        get {
            return ["prediction", "classLabel"]
        }
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        if (featureName == "prediction") {
            return try! MLFeatureValue(dictionary: prediction as [NSObject : NSNumber])
        }
        if (featureName == "classLabel") {
            return MLFeatureValue(string: classLabel)
        }
        return nil
    }
    
    init(prediction: [String : Double], classLabel: String) {
        self.prediction = prediction
        self.classLabel = classLabel
    }
}


/// Class for model loading and prediction
@available(macOS 10.13, iOS 11.0, tvOS 11.0, watchOS 4.0, *)
class pictionairy {
    var model: MLModel

    /**
        Construct a model with explicit path to mlmodel file
        - parameters:
           - url: the file url of the model
           - throws: an NSError object that describes the problem
    */
    init(contentsOf url: URL) throws {
        self.model = try MLModel(contentsOf: url)
    }

    /// Construct a model that automatically loads the model from the app's bundle
    convenience init() {
        let bundle = Bundle(for: pictionairy.self)
        let assetPath = bundle.url(forResource: "pictionairy", withExtension:"mlmodelc")
        try! self.init(contentsOf: assetPath!)
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as pictionairyInput
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as pictionairyOutput
    */
    func prediction(input: pictionairyInput) throws -> pictionairyOutput {
        let outFeatures = try model.prediction(from: input)
        let result = pictionairyOutput(prediction: outFeatures.featureValue(for: "prediction")!.dictionaryValue as! [String : Double], classLabel: outFeatures.featureValue(for: "classLabel")!.stringValue)
        return result
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - image (120x120) as color (kCVPixelFormatType_32BGRA) image buffer, 120 pixels wide by 120 pixels high
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as pictionairyOutput
    */
    func prediction(image__120x120_: CVPixelBuffer) throws -> pictionairyOutput {
        let input_ = pictionairyInput(image__120x120_: image__120x120_)
        return try self.prediction(input: input_)
    }
}
