open Core

module Property = struct
  type t =
    | Date of Date.t
    | Year of int
    | Month of Month.t
    | Day of int
    | DayOfWeek of Day_of_week.t
  [@@deriving sexp]

  let eval t d =
    match t with
    | Date x -> Date.equal d x
    | Year x -> Date.year d = x
    | Month x -> Month.equal (Date.month d) x
    | Day x -> Date.day d = x
    | DayOfWeek x -> Day_of_week.equal (Date.day_of_week d) x
end

type t = Property.t Blang.t
[@@deriving sexp]

let parse input : t = t_of_sexp (Sexp.of_string input)

let eval rule d =
  Blang.eval rule (fun p -> Property.eval p d)

let generate_possible_matches ?(years=1) (rule : t) ~(min : Date.t) =
  let dates = Date.dates_between ~min ~max:(Date.add_years min years) in
  List.filter ~f:(eval rule) dates
