import gleam/int
import gleam/result
import gleam/io
import gleam/option.{type Option, None, Some}

/// Simple Node class containing it's value and pointer to the next Node
pub type Node {
  Node(value: Int, next: Option(Node))
}

/// Generates new nodes untill the length of entire linked list reaches the predefined limit
fn generating(
  max_length: Int,
  current_length: Int,
  previous_node: Option(Node),
) -> Node {
  let value = int.random(100)
  case current_length > max_length {
    True -> {
      Node(value, previous_node)
    }
    False -> {
      case previous_node {
        None -> {
          let head = Node(value, None)
          generating(max_length, current_length + 1, Some(head))
        }
        Some(previous_node) -> {
          let node = Node(value, Some(previous_node))
          generating(max_length, current_length + 1, Some(node))
        }
      }
    }
  }
}

/// Creates a linked list of provided length and returns the first node of it
pub fn generate_random_linked_list(length: Int) -> Node {
  generating(length, 0, None)
}

/// Implementation of the palindrome linked list generating. For the first half of provided length it generates random numbers
/// and prepends them to a list (Instantly reversing the order which helps us to create a reversed latter half) and links Nodes with those numbers.
/// Then in the latter half it extracts reversed values from the list and creates Nodes with them and linking to previous Nodes.
fn generate_random_palindrome_linked_list_impl(
  max_length: Int,
  current_length: Int,
  stack: List(Int),
  previous_node: Option(Node),
) -> Node {
  let half_length = max_length / 2
  case current_length >= max_length {
    True -> option.unwrap(previous_node, Node(0, None))
    False -> {
      case current_length >= half_length {
        True -> {
          case stack {
            [first, ..rest] -> {
              let node = Node(first, previous_node)
              generate_random_palindrome_linked_list_impl(
                max_length,
                current_length + 1,
                rest,
                Some(node),
              )
            }
            _ -> Node(0, None)
          }
        }
        False -> {
          let value = int.random(10)
          let stack = [value, ..stack]
          case previous_node {
            None -> {
              let node = Node(value, None)
              generate_random_palindrome_linked_list_impl(
                max_length,
                current_length + 1,
                stack,
                Some(node),
              )
            }
            Some(previous_node) -> {
              let node = Node(value, Some(previous_node))
              generate_random_palindrome_linked_list_impl(
                max_length,
                current_length + 1,
                stack,
                Some(node),
              )
            }
          }
        }
      }
    }
  }
}

/// Generates a random linked list that is a palindrom i.e. the same traversed from both the front and the back
/// For now it only works with even lengths
pub fn generate_random_palindrome_linked_list(length: Int) -> Node {
  case int.modulo(length, 2) {
    Ok(1) ->
      generate_random_palindrome_linked_list_impl(length - 1, 0, [], None)
    Ok(0) -> generate_random_palindrome_linked_list_impl(length, 0, [], None)
    _ -> panic
  }
}
