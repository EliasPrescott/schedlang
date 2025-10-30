open Core
open Schedlang

let check_date config date =
  let res = Sched_lang.eval config date in
  print_endline (Bool.to_string res)

let list_matching_dates ~config ~start_date ~years =
  let possible_matches = Sched_lang.generate_possible_matches
    ~min:start_date
    ~years
    config
  in
  List.iter ~f:(fun x -> print_endline (Date.to_string x)) possible_matches

let sched_lang_arg_type = Command.Arg_type.create Sched_lang.parse

let sched_lang_param =
  let open Command.Param in
  anon ("schedlang_rule" %: sched_lang_arg_type)

let check_command =
  Command.basic
    ~summary:"Determines if the given date matches the given SchedLang rule"
    (let open Command.Let_syntax in
    let open Command.Param in
    let%map date_param = flag "--date" (optional_with_default (Date.today ~zone:Time_float.Zone.utc) date) ~doc:"date The date to check [defaults to today]."
    and rule_param = sched_lang_param in
    fun () -> check_date rule_param date_param)

let list_dates_command =
  Command.basic
    ~summary:"Lists all dates that match the given SchedLang rule"
    (let open Command.Let_syntax in
    let open Command.Param in
    let%map start_date_param = flag "--start" (optional_with_default (Date.of_string "1970-01-01") date) ~doc:"start_date The date to start generating matches from"
    and years_param = flag "--years" (optional_with_default 4 int) ~doc:"years The number of years to process"
    and rule_param = sched_lang_param in
    fun () -> list_matching_dates ~config:rule_param ~start_date:start_date_param ~years:years_param)

let command =
  Command.group
    ~summary:"Work with SchedLang"
    [
      "check", check_command;
      "list", list_dates_command;
    ]

let () = Command_unix.run
  ~version:"0.1"
  ~build_info:""
  command
