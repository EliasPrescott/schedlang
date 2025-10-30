(lang dune 3.14)

(name schedlang)

(generate_opam_files true)

(source
 (github eliasprescott/schedlang))

(authors "Elias Prescott")

(maintainers "Elias Prescott")

(license MIT)

(package
 (name schedlang)
 (synopsis "A toy config language for specifying date patterns")
 (depends
  (ocaml (= 5.3.0))
  (dune (and (>= 3.14)
             (<= 3.19)))
  (core (>= 0.17.1))
  (core_unix (>= 0.17.1)))
 (tags
  (scheduling)))
