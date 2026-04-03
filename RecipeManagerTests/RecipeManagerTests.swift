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
    
    var container: ModelContainer!
    var context: ModelContext!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // Create a fresh In-Memory container before EVERY test
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: RecipeModel.self, TagModel.self, configurations: config)
        context = ModelContext(container)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        container = nil
        context = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testDatabaseStressLoad() throws {
        // We measure the performance of inserting 100 items
        self.measure {
            RecipesDataService.stressTestDatabase(count: 100, context: context, allTags: [])
            
            // Clean up after each measurement iteration so we don't
            // end up with 1000 items (100 * 10 iterations)
            try? context.save()
        }
        
        let descriptor = FetchDescriptor<RecipeModel>()
        let finalCount = try context.fetchCount(descriptor)
        
        // Assert based on the total accumulated across the 10 measure rounds
        XCTAssertEqual(finalCount, 1000, "Database should contain exactly 1000 items after 10 measurement iterations.")
    }
    
    func testMetricsIntegration() throws {
        // DevOps Test: Verify the app doesn't crash when sending a metric
        // Even if the server is down, the app should handle it gracefully
        XCTAssertNoThrow(MetricsService.sendEvent(.appOpened), "MetricsService should handle network calls without crashing the main thread.")
    }
}
