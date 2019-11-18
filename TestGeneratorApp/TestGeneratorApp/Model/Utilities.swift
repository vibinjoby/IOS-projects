//
//  Utilities.swift
//  TableViewWithMultipleCells
//
//  Created by vibin joby on 2019-11-14.
//  Copyright © 2019 vibin joby. All rights reserved.
//

import Foundation

class Utilities {
    var questions:[Question]?
    
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask)
        print(paths[0])
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Questions.plist")
    }
    
    func loadQuestionsObject() -> [Question]?{
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
            let decoder = PropertyListDecoder()
            do {
                questions = try decoder.decode([Question].self,from: data)
            } catch {
                print("Error decoding item array!")
            }
        }
        return questions != nil ? questions! : nil
        
    }
    
    func saveQuestionsObject(_ qnsObj:[Question]) {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(qnsObj) // 4
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        } catch {
            print("Error encoding item array!")
        }
    }
}
