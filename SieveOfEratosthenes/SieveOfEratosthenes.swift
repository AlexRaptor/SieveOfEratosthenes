//
//  SieveOfEratosthenes.swift
//  SieveOfEratosthenes
//
//  Created by Alexander on 10/04/2019.
//  Copyright © 2019 Alexander Selivanov. All rights reserved.
//

import Foundation

class SieveOfEratosthenes {
    
    private init() {}
    
    static func getPrimeArray(for maximum: Int) -> [Int] {
        
        if maximum < 2 {
            return [Int]()
        }
        
        var array = Array(repeating: true, count: maximum + 1)

        var i = 2
        while (i * i) <= maximum {
            
            if array[i] {
                
                for j in stride(from: (i * i), through: maximum, by: i) {
                    array[j] = false
                }
            }
            
            i += 1
        }
        
        var result = [Int]()
        
        for (index, value) in array.enumerated() {
            if value {
                result.append(index)
            }
        }
        
        result.removeFirst()
        result.removeFirst()
        
        return result
    }
}
