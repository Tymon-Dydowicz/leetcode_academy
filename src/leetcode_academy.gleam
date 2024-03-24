import argv
import gleam/io
import reverse_linked_list
import palindrome_linked_list
import reorder_linked_list
import duplicate_int

pub fn main() {
  case argv.load().arguments {
    ["Run_task", number] ->
      case number {
        "206" -> reverse_linked_list.main()
        "234" -> palindrome_linked_list.main()
        "143" -> reorder_linked_list.main()
        "287" -> duplicate_int.main()
        _ ->
          io.println(
            "Task #"
            <> number
            <> " Was not yet solved \n"
            <> "Currently implemented tasks are: 206, 234, 143, 287",
          )
      }
    _ ->
      io.println(
        "Please run the program with \"Run_task #\" and replace # with number of leetcode task",
      )
  }
}
