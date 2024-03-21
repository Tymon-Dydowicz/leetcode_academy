import gleam/io
import gleam/int
import gleam/result
import gleam/option.{type Option, None, Some}

/// Simple Node class containing it's value and pointer to the next Node
pub type Node {
  Node(value: Int, next: Option(Node))
}

/// Simply traverses the linked list by going node by node and printing node's value
pub fn traverse_linked_list(head: Node) -> String {
  case head.next {
    None -> {
      io.println(int.to_string(head.value))
      io.debug("End of list")
    }
    Some(next) -> {
      io.print(int.to_string(head.value) <> " ")
      traverse_linked_list(next)
    }
  }
}

/// Given the first node of some single linked list it return a node that is the head
/// of completely reversed linked list
pub fn reverse_linked_list(current: Node, previous: Option(Node)) -> Node {
  case current.next {
    None -> Node(current.value, previous)
    Some(next) -> {
      case previous {
        None -> reverse_linked_list(next, Some(Node(current.value, None)))
        Some(previous) ->
          reverse_linked_list(next, Some(Node(current.value, Some(previous))))
      }
    }
  }
}

/// The array has to be reversed due to the way it's implemented in Gleam so that appending
/// to the list is very inefficient, requires copying and traversing entire array and since we created
/// reverse_linked_list function we don't need to worry about it
pub fn linked_list_to_reversed_array(
  head: Node,
  accumulator: List(Int),
) -> List(Int) {
  case head.next {
    None -> [head.value, ..accumulator]
    Some(next) -> {
      let accumulator = [head.value, ..accumulator]
      linked_list_to_reversed_array(next, accumulator)
    }
  }
}

/// Generates new nodes untill the length of entire linked list reaches the predefined limit
fn generating(
  max_length: Int,
  current_length: Int,
  previous_node: Option(Node),
) -> Node {
  let value = int.random(100)
  case current_length {
    current_length if current_length > max_length -> {
      Node(value, previous_node)
    }
    current_length if current_length <= max_length -> {
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
    _ -> Node(0, None)
  }
}

/// Creates a linked list of provided length and returns the first node of it
pub fn generate_random_linked_list(length: Int) {
  let head = generating(length, 0, None)
  head
}

fn run_test(times: Int, counter: Int) {
  case counter {
    counter if counter < times -> {
      let list = generate_random_linked_list({ counter + 1 } * 10)
      let reversed = reverse_linked_list(list, None)
      traverse_linked_list(list)
      traverse_linked_list(reversed)
      run_test(times, counter + 1)
    }
    _ -> io.println("Finished")
  }
}

pub fn main() {
  run_test(5, 0)
}
