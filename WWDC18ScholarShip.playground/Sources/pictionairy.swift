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

    /// Source provided by CoreML

    private let provider : MLFeatureProvider


    /// prediction as dictionary of strings to doubles
    lazy var prediction: [String : Double] = {
        [unowned self] in return self.provider.featureValue(for: "prediction")!.dictionaryValue as! [String : Double]
    }()

    /// classLabel as string value
    lazy var classLabel: String = {
        [unowned self] in return self.provider.featureValue(for: "classLabel")!.stringValue
    }()

    var featureNames: Set<String> {
        return self.provider.featureNames
    }
    
    func featureValue(for featureName: String) -> MLFeatureValue? {
        return self.provider.featureValue(for: featureName)
    }

    init(prediction: [String : Double], classLabel: String) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["prediction" : MLFeatureValue(dictionary: prediction as [AnyHashable : NSNumber]), "classLabel" : MLFeatureValue(string: classLabel)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
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
        return try self.prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface
        - parameters:
           - input: the input to the prediction as pictionairyInput
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as pictionairyOutput
    */
    func prediction(input: pictionairyInput, options: MLPredictionOptions) throws -> pictionairyOutput {
        let outFeatures = try model.prediction(from: input, options:options)
        return pictionairyOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface
        - parameters:
            - image__120x120_ as color (kCVPixelFormatType_32BGRA) image buffer, 120 pixels wide by 120 pixels high
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as pictionairyOutput
    */
    func prediction(image__120x120_: CVPixelBuffer) throws -> pictionairyOutput {
        let input_ = pictionairyInput(image__120x120_: image__120x120_)
        return try self.prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface
        - parameters:
           - inputs: the inputs to the prediction as [pictionairyInput]
           - options: prediction options 
        - throws: an NSError object that describes the problem
        - returns: the result of the prediction as [pictionairyOutput]
    */
    func predictions(inputs: [pictionairyInput], options: MLPredictionOptions) throws -> [pictionairyOutput] {
        if #available(macOS 10.14, iOS 12.0, tvOS 12.0, watchOS 5.0, *) {
            let batchIn = MLArrayBatchProvider(array: inputs)
            let batchOut = try model.predictions(from: batchIn, options: options)
            var results : [pictionairyOutput] = []
            results.reserveCapacity(inputs.count)
            for i in 0..<batchOut.count {
                let outProvider = batchOut.features(at: i)
                let result =  pictionairyOutput(features: outProvider)
                results.append(result)
            }
            return results
        } else {
            var results : [pictionairyOutput] = []
            results.reserveCapacity(inputs.count)
            for input in inputs {
                let result = try self.prediction(input: input, options: options)
                results.append(result)
            }
            return results
        }
    }
}
