import util_generators
import gleam/io
import gleam/list

fn find_duplicate_impl1(checked_list: List(Int), mem: List(Int)) -> Int {
  case checked_list {
    [first, ..rest] -> {
      case list.contains(mem, any: first) {
        True -> first
        False -> {
          let mem = [first, ..mem]
          find_duplicate_impl1(rest, mem)
        }
      }
    }
    _ -> -1
  }
}

pub fn find_duplicate(list: List(Int)) -> Int {
  find_duplicate_impl1(list, [])
}

pub fn main() {
  let list = util_generators.generate_random_array(10)
  io.debug(list)
  find_duplicate(list)
  |> io.debug()
  io.println("Done")
}
