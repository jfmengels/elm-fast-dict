module Insert exposing (main)

import Benchmark exposing (Benchmark)
import Benchmark.Runner exposing (BenchmarkProgram, program)
import FastSet as Set exposing (Set)


suite : Benchmark
suite =
    let
        noDuplicates : List Int
        noDuplicates =
            List.range 0 1000

        withDuplicates : List Int
        withDuplicates =
            List.range 0 200
                |> List.concatMap (\i -> List.repeat 5 i)
    in
    Benchmark.describe "FastSet.insert"
        [ Benchmark.compare "1000 elements, no duplicates"
            "original"
            (\() -> List.foldl Set.oldInsert Set.empty noDuplicates)
            "new version"
            (\() -> List.foldl Set.insert Set.empty noDuplicates)
        , Benchmark.compare "1000 elements, with duplicates"
            "original"
            (\() -> List.foldl Set.oldInsert Set.empty withDuplicates)
            "new version"
            (\() -> List.foldl Set.insert Set.empty withDuplicates)
        ]


main : BenchmarkProgram
main =
    program suite
