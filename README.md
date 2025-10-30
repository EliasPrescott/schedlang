# SchedLang

A toy config language and tool for writing date scheduling patterns.

## Examples

```bash
> schedlang check "(And (Day 31) (Month Oct))" --date 2025-10-31
true
```

```bash
> schedlang list "(And (Day 29) (Month Feb))" --years 20 --start 2025-01-01
2028-02-29
2032-02-29
2036-02-29
2040-02-29
2044-02-29
```

```bash
> cat examples/friday-october-thirteenth.sl | xargs -I {} schedlang list "{}" --years 100 --start 2000-01-01
2000-10-13
2006-10-13
2017-10-13
2023-10-13
2028-10-13
2034-10-13
2045-10-13
2051-10-13
2056-10-13
2062-10-13
2073-10-13
2079-10-13
2084-10-13
2090-10-13
```
