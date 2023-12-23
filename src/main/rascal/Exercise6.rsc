module Exercise6

import IO;
import Exercise5;

public void exercise6(){
    list[str] eu = ["Austria", "Belgium", "Bulgaria", "Czech Republic",
    "Cyprus", "Denmark", "Estonia", "Finland", "France", "Germany","Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania",
    "Luxembourg", "Malta", "The Netherlands", "Poland", "Portugal", "Romania", "Slovenia", "Slovakia", "Spain", "Sweden", "United Kingdom"];

    //contains the letter s
    println({ a | a <- eu, /s/i := a });
    //test

    //contains (at least) two e's
    println({a | a <- eu, /e.*e/i :=a });

    //contains exactly two e’s
    println({a | a <- eu, /e.e/i :=a });

    //contains no n and also no e
    println({ a | a <- eu, /^[^en]*$/i := a });

    //contains any letter at least twice
    println({ a | a <- eu, /<x:[a-z]>.*<x>/i := a });

    //contains an a: the first a in the name is replaced by an o (for example:"Malta" becomes "Molta")
    println({ begin+"o"+eind | a <- eu, /^<begin:[^a]*>a<eind:.*>$/i:= a });
}