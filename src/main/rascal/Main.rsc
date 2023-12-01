module Main

import IO;
import List;
import Map;
import Relation;
import Set;


int main(int testArgument=0) {
    println("argument: <testArgument>");
    return testArgument;
}

public void exercise5() {
    println("Hello");
}

public void exercise6(){
    list[str] eu = ["Austria", "Belgium", "Bulgaria", "Czech Republic",
    "Cyprus", "Denmark", "Estonia", "Finland", "France", "Germany","Greece", "Hungary", "Ireland", "Italy", "Latvia", "Lithuania",
    "Luxembourg", "Malta", "The Netherlands", "Poland", "Portugal", "Romania", "Slovenia", "Slovakia", "Spain", "Sweden", "United Kingdom"];

    //contains the letter s
    println({ a | a <- eu, /s/i := a });

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

public rel[int, int] delers(int maxnum) {
    return { <a, b> | a <- [1..maxnum], b <- [1..a+1], a%b==0 };
}


public void exercise7(){
    //Compute the relationship between the natural numbers up to 100 and their divisors
    rel[int, int] d = delers(100);
    println(d);

    //Compute which numbers have the most divisors.
    println("-");
    map[int, int] m = (a:size(d[a]) | a <- domain(d));
    int maxdiv = max(range(m));
    println({ a | a <- domain(d), m[a] == maxdiv });

    //Compute the list of prime numbers (up to 100) in ascending order.
    println("-");
    println(sort([ a | a <- domain(m), m[a] == 2 ]));
}
