public class Trie {
  static let validCharacters: [Character] = "abcdefghijklmnopqrstuvwxyz".map { Character(extendedGraphemeClusterLiteral: $0) }
  
  public struct Node {
    var children = [Character: Node]()
    var isTerminal = false
    let value: Character?
  }
  
  private var root = Node(value: nil)
  
  public func insert(key: String) {
    root = insert(node: &root, remainingKey: key)
  }
  
  public func delete(key: String) {
    root = delete(node: &root, remainingKey: key)
  }
  
  /**
   Recurse through the trie until we find and delete the key we're looking for or run out of options to find it
   - Returns: A `Node` that represents the updated root of the sub-trie after the delete operation
   */
  @discardableResult private func delete(node: inout Node, remainingKey: String) -> Node {
    guard let nextValue = remainingKey.first else {
      node.isTerminal = false
      return node
    }
    
    guard node.children[nextValue] != nil else { return node }
    
    delete(node: &node.children[nextValue]!,
           remainingKey: String(remainingKey.suffix(remainingKey.count - 1)))
    
    return node
  }
  
  public func search(key: String) -> Bool {
    var currentNode = root
    
    for char in key {
      guard let nextNode = currentNode.children[char] else { return false }
      
      currentNode = nextNode
    }
    
    return currentNode.isTerminal
  }
  
  /**
   Recurse through the trie adding as many nodes as we need to insert the full key
   - Returns : a `Node` that represents the updated root of the sub-trie
   */
  @discardableResult private func insert(node: inout Node, remainingKey: String) -> Node {
    // If we're out of key, we're done
    guard let nextValue = remainingKey.first else {
      node.isTerminal = true
      return node
    }
    
    // If we don't find the next letter of the key, create a new node
    if node.children[nextValue] == nil {
      let newNode = Node(value: nextValue)
      node.children[nextValue] = newNode
    }
    
    insert(node: &node.children[nextValue]!,
           remainingKey: String(remainingKey.suffix(remainingKey.count - 1)))
    
    return node
  }
}
