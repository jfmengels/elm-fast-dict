module Filter exposing (main)


import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import FastDict exposing (Dict)


suite : Benchmark
suite =
    let
        dict : Dict Int Int
        dict =
            List.range 0 1000
                |> List.map (\n -> ( n, n ))
                |> FastDict.fromList
    in
    Benchmark.compare "FastDict.filter (1000 elements)"
        "original"
        (\() -> FastDict.filter f dict)
        "new version"
        (\() -> FastDict.filter2 f dict)


f : a -> Int -> Bool
f _ v =
    modBy 2 v == 0


main : BenchmarkProgram
main =
    program suite
