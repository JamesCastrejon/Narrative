//
//  Book.swift
//  Narrative
//
//  Created by James Castrejon on 3/16/19.
//  Copyright © 2019 James Castrejon. All rights reserved.
//

import Foundation
import UIKit

struct Book {
    
    static var orderedViewControllers: [UIViewController] = []
    static var pageNumber: Int = 0
    
    mutating func initialize() {
        Book.orderedViewControllers = [
        newPage(type: "FrontCover"),
        newPage(type: "Page"),
        newPage(type: "BackCover")]
    }
    
    func newPage(type: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "\(type)")
    }
    
    mutating func addPage(after identifier: String) {
        if Book.orderedViewControllers.count < 20 && identifier != "BackCover" {
            Book.orderedViewControllers.insert(newPage(type: "Page"), at: Book.pageNumber + 1)
        }
    }
    
    mutating func deletePage() {
        Book.orderedViewControllers.remove(at: Book.pageNumber + 1)
    }
    
}
