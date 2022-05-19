import XCTest
@testable import Trie

final class TrieTests: XCTestCase {
  func testInsert() {
    let trie = Trie()
    
    trie.insert(key: "kevin")
    XCTAssertTrue(trie.search(key: "kevin"))
    XCTAssertFalse(trie.search(key: "kev"))
  }
  
  func testDelete() {
    let trie = Trie()
    
    trie.insert(key: "abc")
    trie.insert(key: "ab")
    trie.insert(key: "abd")
    
    XCTAssertTrue(trie.search(key: "abc"))
    XCTAssertTrue(trie.search(key: "ab"))
    XCTAssertTrue(trie.search(key: "abd"))
    
    trie.delete(key: "ab")
    
    XCTAssertTrue(trie.search(key: "abc"))
    XCTAssertFalse(trie.search(key: "ab"))
    XCTAssertTrue(trie.search(key: "abd"))
  }
}
