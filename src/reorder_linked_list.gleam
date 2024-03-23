import util_generators.{type Node, Node}
import reverse_linked_list.{reverse_linked_list, traverse_linked_list}
import gleam/option.{type Option, None, Some}
import gleam/io

fn get_list_length_impl(head: Node, accumulator: Int) -> Int {
  let accumulator = accumulator + 1
  case head.next {
    None -> accumulator
    Some(next) -> get_list_length_impl(next, accumulator)
  }
}

pub fn get_list_length(head: Node) -> Int {
  get_list_length_impl(head, 0)
}

fn create_reorded_linked_list(
  normal: Node,
  reversed: Node,
  max_length: Int,
  current_length: Int,
  previous_node: Option(Node),
) -> Node {
  case previous_node, current_length >= max_length {
    _, True -> option.unwrap(previous_node, Node(0, None))
    None, False -> {
      let first_node = Node(normal.value, None)
      let second_node = Node(reversed.value, Some(first_node))
      create_reorded_linked_list(
        option.unwrap(normal.next, Node(0, None)),
        option.unwrap(reversed.next, Node(0, None)),
        max_length,
        current_length + 2,
        Some(second_node),
      )
    }
    Some(previous_node), False -> {
      let first_node = Node(normal.value, Some(previous_node))
      let second_node = Node(reversed.value, Some(first_node))
      create_reorded_linked_list(
        option.unwrap(normal.next, Node(0, None)),
        option.unwrap(reversed.next, Node(0, None)),
        max_length,
        current_length + 2,
        Some(second_node),
      )
    }
  }
}

pub fn reorder_linked_list(head: Node) -> Node {
  let length = get_list_length(head)
  let reversed = reverse_linked_list(head)
  create_reorded_linked_list(head, reversed, length, 0, None)
  |> reverse_linked_list()
}

fn run_test(times: Int, counter: Int) -> Nil {
  case counter {
    counter if counter < times -> {
      let list =
        util_generators.generate_random_linked_list({ counter + 1 } * 10)
      let reordered = reorder_linked_list(list)
      traverse_linked_list(list)
      traverse_linked_list(reordered)
      run_test(times, counter + 1)
    }
    _ -> io.println("Finished")
  }
}

pub fn main() {
  run_test(5, 0)
  io.println("Done")
}
