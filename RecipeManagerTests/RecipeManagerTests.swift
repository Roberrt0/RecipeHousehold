//
//  RecipeManagerTests.swift
//  RecipeManagerTests
//
//  Created by Luis Roberto Martinez on 30/08/24.
//

import XCTest
import SwiftData
@testable import RecipeManager

final class RecipeManagerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDatabaseStressLoad() throws {
        // Create a "Clean" In-Memory Container for the testing session
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RecipeModel.self, TagModel.self, configurations: config)
        let context = ModelContext(container)
        
        
        // Run this 10 times and measure the time
        self.measure {
            // Stress the database with the Service class
            RecipesDataService.stressTestDatabase(count: 100, context: context, allTags: [])
        }
        
        // Get the # of items generated
        let descriptor = FetchDescriptor<RecipeModel>()
        let count = try context.fetchCount(descriptor)
        
        // make sure the # of generated items is correct
        XCTAssertEqual(count, 1000, "Database should contain exactly 1000 items.")
    }
}
