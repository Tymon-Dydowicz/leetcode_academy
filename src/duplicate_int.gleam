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

fn run_test(times: Int, counter: Int) -> Nil {
  case counter {
    counter if counter < times -> {
      util_generators.generate_random_array({ counter + 1 } * 10)
      |> io.debug()
      |> find_duplicate()
      |> io.debug()
      run_test(times, counter + 1)
    }
    _ -> io.println("Finished")
  }
}

pub fn main() {
  run_test(5, 0)
  io.println("Done")
}
