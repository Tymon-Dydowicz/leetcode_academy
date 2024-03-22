import gleam/io
import gleam/int
import util_generators.{type Node, Node}
import gleam/option.{type Option, None, Some}

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

fn reverse_linked_list_impl(current: Node, previous: Option(Node)) {
  case current.next {
    None -> Node(current.value, previous)
    Some(next) -> {
      case previous {
        None -> reverse_linked_list_impl(next, Some(Node(current.value, None)))
        Some(previous) ->
          reverse_linked_list_impl(
            next,
            Some(Node(current.value, Some(previous))),
          )
      }
    }
  }
}

/// Given the first node of some single linked list it return a node that is the head
/// of completely reversed linked list
pub fn reverse_linked_list(current: Node) -> Node {
  reverse_linked_list_impl(current, None)
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

fn run_test(times: Int, counter: Int) -> Nil {
  case counter {
    counter if counter < times -> {
      let list =
        util_generators.generate_random_linked_list({ counter + 1 } * 10)
      let reversed = reverse_linked_list(list)
      traverse_linked_list(list)
      traverse_linked_list(reversed)
      run_test(times, counter + 1)
    }
    _ -> io.println("Finished")
  }
}

pub fn main() -> Nil {
  run_test(5, 0)
}
