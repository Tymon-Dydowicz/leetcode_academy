import util_generators.{
  type Node, Node, generate_random_linked_list,
  generate_random_palindrome_linked_list,
}
import gleam/option.{type Option, None, Some}
import reverse_linked_list.{reverse_linked_list}
import gleam/io
import gleam/int
import gleam/float

/// Compares the lists by going over all nodes in the same order and checking whether the value is identical
fn compare_lists(head1: Option(Node), head2: Option(Node)) -> Bool {
  case head1, head2 {
    None, None -> True
    None, Some(_) -> False
    Some(_), None -> False
    Some(head1), Some(head2) -> {
      case head1.value == head2.value {
        True -> compare_lists(head1.next, head2.next)
        False -> False
      }
    }
  }
}

/// Naively checks whether linked list is a palindrome by using previously implemented reversing function
/// and comparing the list with it's reversed version
pub fn check_if_palindrome_naive(head: Node) -> Bool {
  let reversed = reverse_linked_list(head)
  compare_lists(Some(head), Some(reversed))
}

fn run_test(times: Int, counter: Int, successes: Int) -> Nil {
  let length = int.random(10_000)
  case counter < times {
    True -> {
      case int.random(2) {
        0 -> {
          let tested_list = generate_random_palindrome_linked_list(length)
          case check_if_palindrome_naive(tested_list) {
            True -> run_test(times, counter + 1, successes + 1)
            False -> run_test(times, counter + 1, successes)
          }
        }
        1 -> {
          let tested_list = generate_random_linked_list(length)
          case check_if_palindrome_naive(tested_list) {
            True -> run_test(times, counter + 1, successes)
            False -> run_test(times, counter + 1, successes + 1)
          }
        }
        _ -> panic
      }
    }
    False -> {
      io.println(
        "The accuracy is: "
        <> float.to_string(int.to_float(successes) /. int.to_float(counter)),
      )
    }
  }
}

pub fn main() {
  run_test(20_000, 0, 0)
  io.println("Done")
}
