//
//  MachineLearningManager.swift
//  TENNIS MOTION
//
//  Created by Mac on 6/2/22.
//
import Foundation
import CoreML


class MachineLearningManager: ObservableObject
{
    func level_classification(list_features : [Float], output_label: Int) -> String
    {
        var label = ""
        let config = MLModelConfiguration()

        if output_label == 1 {
            let classifier_level = try! Level_Fd_grav(configuration: config)
            let output_label = try! classifier_level.prediction(aXmax: Double(list_features[0]), aYmax: Double(list_features[1]), aZmax: Double(list_features[2]), aXmin: Double(list_features[3]), aYmin: Double(list_features[4]), aZmin: Double(list_features[5]), aXmean: Double(list_features[6]), aYmean: Double(list_features[7]), aZmean: Double(list_features[8]), aXstd: Double(list_features[9]), aYstd: Double(list_features[10]), aZstd: Double(list_features[11]), aXArea: Double(list_features[12]), aYArea: Double(list_features[13]), aZArea: Double(list_features[14]), gXmax: Double(list_features[15]), gYmax: Double(list_features[16]), gZmax: Double(list_features[17]), gXmin: Double(list_features[18]), gYmin: Double(list_features[19]), gZmin: Double(list_features[20]), gXmean: Double(list_features[21]), gYmean: Double(list_features[22]), gZmean: Double(list_features[23]), gXstd: Double(list_features[24]), gYstd: Double(list_features[25]), gZstd: Double(list_features[26]), gXArea: Double(list_features[27]), gYArea: Double(list_features[28]), gZArea: Double(list_features[29]), gravXmax: Double(list_features[30]), gravYmax: Double(list_features[31]), gravZmax: Double(list_features[32]), gravXmin: Double(list_features[33]), gravYmin: Double(list_features[34]), gravZmin: Double(list_features[35]), gravXmean: Double(list_features[36]), gravYmean: Double(list_features[37]), gravZmean: Double(list_features[38]), gravXstd: Double(list_features[39]), gravYstd: Double(list_features[40]), gravZstd: Double(list_features[41]), gravXArea: Double(list_features[42]), gravYArea: Double(list_features[43]), gravZArea: Double(list_features[44]))

            if output_label.Class_ == 1 {
                label = "Expert"
            }
            else {
                label = "Novice"
            }
        }
        if output_label == 2 {
            let classifier_level = try! Level_Bd_grav(configuration: config)
            let output_label = try! classifier_level.prediction(aXmax: Double(list_features[0]), aYmax: Double(list_features[1]), aZmax: Double(list_features[2]), aXmin: Double(list_features[3]), aYmin: Double(list_features[4]), aZmin: Double(list_features[5]), aXmean: Double(list_features[6]), aYmean: Double(list_features[7]), aZmean: Double(list_features[8]), aXstd: Double(list_features[9]), aYstd: Double(list_features[10]), aZstd: Double(list_features[11]), aXArea: Double(list_features[12]), aYArea: Double(list_features[13]), aZArea: Double(list_features[14]), gXmax: Double(list_features[15]), gYmax: Double(list_features[16]), gZmax: Double(list_features[17]), gXmin: Double(list_features[18]), gYmin: Double(list_features[19]), gZmin: Double(list_features[20]), gXmean: Double(list_features[21]), gYmean: Double(list_features[22]), gZmean: Double(list_features[23]), gXstd: Double(list_features[24]), gYstd: Double(list_features[25]), gZstd: Double(list_features[26]), gXArea: Double(list_features[27]), gYArea: Double(list_features[28]), gZArea: Double(list_features[29]), gravXmax: Double(list_features[30]), gravYmax: Double(list_features[31]), gravZmax: Double(list_features[32]), gravXmin: Double(list_features[33]), gravYmin: Double(list_features[34]), gravZmin: Double(list_features[35]), gravXmean: Double(list_features[36]), gravYmean: Double(list_features[37]), gravZmean: Double(list_features[38]), gravXstd: Double(list_features[39]), gravYstd: Double(list_features[40]), gravZstd: Double(list_features[41]), gravXArea: Double(list_features[42]), gravYArea: Double(list_features[43]), gravZArea: Double(list_features[44]))

            if (output_label.Class_) == 1 {
                label = "Expert"
            }
            else {
                label = "Novice"
            }
        }
        if output_label == 3 {
            let classifier_level = try! Level_S_grav(configuration: config)
            let output_label = try! classifier_level.prediction(aXmax: Double(list_features[0]), aYmax: Double(list_features[1]), aZmax: Double(list_features[2]), aXmin: Double(list_features[3]), aYmin: Double(list_features[4]), aZmin: Double(list_features[5]), aXmean: Double(list_features[6]), aYmean: Double(list_features[7]), aZmean: Double(list_features[8]), aXstd: Double(list_features[9]), aYstd: Double(list_features[10]), aZstd: Double(list_features[11]), aXArea: Double(list_features[12]), aYArea: Double(list_features[13]), aZArea: Double(list_features[14]), gXmax: Double(list_features[15]), gYmax: Double(list_features[16]), gZmax: Double(list_features[17]), gXmin: Double(list_features[18]), gYmin: Double(list_features[19]), gZmin: Double(list_features[20]), gXmean: Double(list_features[21]), gYmean: Double(list_features[22]), gZmean: Double(list_features[23]), gXstd: Double(list_features[24]), gYstd: Double(list_features[25]), gZstd: Double(list_features[26]), gXArea: Double(list_features[27]), gYArea: Double(list_features[28]), gZArea: Double(list_features[29]), gravXmax: Double(list_features[30]), gravYmax: Double(list_features[31]), gravZmax: Double(list_features[32]), gravXmin: Double(list_features[33]), gravYmin: Double(list_features[34]), gravZmin: Double(list_features[35]), gravXmean: Double(list_features[36]), gravYmean: Double(list_features[37]), gravZmean: Double(list_features[38]), gravXstd: Double(list_features[39]), gravYstd: Double(list_features[40]), gravZstd: Double(list_features[41]), gravXArea: Double(list_features[42]), gravYArea: Double(list_features[43]), gravZArea: Double(list_features[44]))

            if (output_label.Class_) == 1 {
                label = "Expert"
            }
            else {
                label = "Novice"
            }
        }
        if output_label == 4 {
            let classifier_level = try! Level_FdV_grav(configuration: config)
            let output_label = try! classifier_level.prediction(aXmax: Double(list_features[0]), aYmax: Double(list_features[1]), aZmax: Double(list_features[2]), aXmin: Double(list_features[3]), aYmin: Double(list_features[4]), aZmin: Double(list_features[5]), aXmean: Double(list_features[6]), aYmean: Double(list_features[7]), aZmean: Double(list_features[8]), aXstd: Double(list_features[9]), aYstd: Double(list_features[10]), aZstd: Double(list_features[11]), aXArea: Double(list_features[12]), aYArea: Double(list_features[13]), aZArea: Double(list_features[14]), gXmax: Double(list_features[15]), gYmax: Double(list_features[16]), gZmax: Double(list_features[17]), gXmin: Double(list_features[18]), gYmin: Double(list_features[19]), gZmin: Double(list_features[20]), gXmean: Double(list_features[21]), gYmean: Double(list_features[22]), gZmean: Double(list_features[23]), gXstd: Double(list_features[24]), gYstd: Double(list_features[25]), gZstd: Double(list_features[26]), gXArea: Double(list_features[27]), gYArea: Double(list_features[28]), gZArea: Double(list_features[29]), gravXmax: Double(list_features[30]), gravYmax: Double(list_features[31]), gravZmax: Double(list_features[32]), gravXmin: Double(list_features[33]), gravYmin: Double(list_features[34]), gravZmin: Double(list_features[35]), gravXmean: Double(list_features[36]), gravYmean: Double(list_features[37]), gravZmean: Double(list_features[38]), gravXstd: Double(list_features[39]), gravYstd: Double(list_features[40]), gravZstd: Double(list_features[41]), gravXArea: Double(list_features[42]), gravYArea: Double(list_features[43]), gravZArea: Double(list_features[44]))

            if (output_label.Class_) == 1 {
                label = "Expert"
            }
            else {
                label = "Novice"
            }
        }
        if output_label == 5 {
            let classifier_level = try! Level_BdV_grav(configuration: config)
            let output_label = try! classifier_level.prediction(aXmax: Double(list_features[0]), aYmax: Double(list_features[1]), aZmax: Double(list_features[2]), aXmin: Double(list_features[3]), aYmin: Double(list_features[4]), aZmin: Double(list_features[5]), aXmean: Double(list_features[6]), aYmean: Double(list_features[7]), aZmean: Double(list_features[8]), aXstd: Double(list_features[9]), aYstd: Double(list_features[10]), aZstd: Double(list_features[11]), aXArea: Double(list_features[12]), aYArea: Double(list_features[13]), aZArea: Double(list_features[14]), gXmax: Double(list_features[15]), gYmax: Double(list_features[16]), gZmax: Double(list_features[17]), gXmin: Double(list_features[18]), gYmin: Double(list_features[19]), gZmin: Double(list_features[20]), gXmean: Double(list_features[21]), gYmean: Double(list_features[22]), gZmean: Double(list_features[23]), gXstd: Double(list_features[24]), gYstd: Double(list_features[25]), gZstd: Double(list_features[26]), gXArea: Double(list_features[27]), gYArea: Double(list_features[28]), gZArea: Double(list_features[29]), gravXmax: Double(list_features[30]), gravYmax: Double(list_features[31]), gravZmax: Double(list_features[32]), gravXmin: Double(list_features[33]), gravYmin: Double(list_features[34]), gravZmin: Double(list_features[35]), gravXmean: Double(list_features[36]), gravYmean: Double(list_features[37]), gravZmean: Double(list_features[38]), gravXstd: Double(list_features[39]), gravYstd: Double(list_features[40]), gravZstd: Double(list_features[41]), gravXArea: Double(list_features[42]), gravYArea: Double(list_features[43]), gravZArea: Double(list_features[44]))

            if (output_label.Class_) == 1 {
                label = "Expert"
            }
            else {
                label = "Novice"
            }
        }

        return label
    }
    
    
}
