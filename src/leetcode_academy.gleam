import argv
import gleam/io
import reverse_linked_list

pub fn main() {
  case argv.load().arguments {
    ["Run_task", number] ->
      case number {
        "206" -> reverse_linked_list.main()
        _ -> io.println("Task #" <> number <> " Was not yet solved")
      }
    _ ->
      io.println(
        "Please run the program with \"Run_task #\" and replace # with number of leetcode task",
      )
  }
}
