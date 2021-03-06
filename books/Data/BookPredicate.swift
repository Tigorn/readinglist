//
//  BookPredicate.swift
//  books
//
//  Created by Andrew Bennet on 28/03/2016.
//  Copyright © 2016 Andrew Bennet. All rights reserved.
//

import Foundation

class BookPredicate {
    
    private static let titleFieldName = "title"
    private static let authorFieldName = "authorList"
    
    private static let sortFieldName = "sort"
    private static let startedReadingFieldName = "startedReading"
    private static let finishedReadingFieldName = "finishedReading"
    
    static let readStateFieldName = "readState"
    static let isbnFieldName = "isbn13"
    private static let googleBooksIdFieldName = "googleBooksId"
    
    static func readState(equalTo readState: BookReadState) -> NSPredicate {
        return NSPredicate(intFieldName: readStateFieldName, equalTo: Int(readState.rawValue))
    }
    
    static func search(searchString: String) -> NSPredicate {
        return NSPredicate.wordsWithinFields(searchString, fieldNames: titleFieldName, authorFieldName, "ANY subjects.name")
    }
    
    static func isbnEqual(to isbn: String) -> NSPredicate {
        return NSPredicate(stringFieldName: isbnFieldName, equalTo: isbn)
    }
    
    static func googleBooksIdEqual(to googleBooksId: String) -> NSPredicate {
        return NSPredicate(stringFieldName: googleBooksIdFieldName, equalTo: googleBooksId)
    }

    static let titleSort = NSSortDescriptor(key: titleFieldName, ascending: true)
    static let startedReadingSort = NSSortDescriptor(key: startedReadingFieldName, ascending: true)
    static let startedReadingDescendingSort = NSSortDescriptor(key: startedReadingFieldName, ascending: false)
    static let finishedReadingSort = NSSortDescriptor(key: finishedReadingFieldName, ascending: true)
    static let finishedReadingDescendingSort = NSSortDescriptor(key: finishedReadingFieldName, ascending: false)
    static let readStateSort = NSSortDescriptor(key: readStateFieldName, ascending: true)
    static let sortIndexSort = NSSortDescriptor(key: sortFieldName, ascending: true)
    static let sortIndexDescendingSort = NSSortDescriptor(key: sortFieldName, ascending: false)
}
