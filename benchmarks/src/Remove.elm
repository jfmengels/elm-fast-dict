module Remove exposing (main)

import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import FastDict as Dict exposing (Dict)


suite : Benchmark
suite =
    let
        range : List Float
        range =
            List.range 0 1000
                |> List.map toFloat

        rangeButExtras : List Float
        rangeButExtras =
            List.concatMap (\i -> [ i, i + 0.5 ]) range

        dict : Dict Float Float
        dict =
            range
                |> List.map (\i -> ( i, i ))
                |> Dict.fromList
    in
    Benchmark.describe "FastDict.remove"
        [ Benchmark.compare "1000 elements, remove all one by one"
            "original"
            (\() -> List.foldl Dict.oldRemove dict range)
            "new version"
            (\() -> List.foldl Dict.remove dict range)
        , Benchmark.compare "1000 elements, remove all but half are missing"
            "original"
            (\() -> List.foldl Dict.oldRemove dict rangeButExtras)
            "new version"
            (\() -> List.foldl Dict.remove dict rangeButExtras)
        ]


main : BenchmarkProgram
main =
    program suite
