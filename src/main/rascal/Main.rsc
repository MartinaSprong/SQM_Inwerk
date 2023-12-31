module Main

import IO;
import List;
import Map;
import Relation;
import Set;
import analysis::graphs::Graph;
import lang::java::m3::Core;
import lang::java::m3::AST;
import vis::Charts;
import vis::Graphs;
import Content;

import Exercise5;

int main(int testArgument=0) {
    println("argument: <testArgument>");
    return testArgument;
}

public rel[int, int] delers(int maxnum) {
    return { <a, b> | a <- [1..maxnum], b <- [1..a+1], a%b==0 };
}

public void exercise5FromOtherModule() {
    println(exercise5());
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

public Graph[str] PointsAndDirections = {<"A", "B">, <"A", "D">, <"B", "D">, <"B", "E">, <"C", "B">, <"C", "E">, <"C", "F">, <"E", "D">, <"E", "F">};

public void exercise8(){
    //a. How many components does the system consist of?
    println(size(carrier(PointsAndDirections)));

    //b. How many dependencies are there between the components?
    println(size(PointsAndDirections));

    //c. Which components are not used by any component?
    println(top(PointsAndDirections));

    //d. Which components are needed (directly or indirectly) for A?
    println((PointsAndDirections+)["A"]);

    //e. Which components are not used (directly or indirectly) by C?
    total = carrier(PointsAndDirections);
    println(total - (PointsAndDirections*)["C"]);

    //f. How often is each component used?
    println(( a:size(invert(PointsAndDirections)[a]) | a <- total ));
}

public bool descending(tuple[&a, num] x, tuple[&a, num] y) {
    return x[1] > y[1];
}

public map[loc, int] linesPerFile (M3 model) {
    set[loc] bestanden = files(model);
    return ( a:size(readFileLines(a)) | a <- bestanden );
}

public rel[str, Statement] methodsAST(tree) {
    rel[str, Statement] result = {};
    visit (tree) {
        case \method(_, name, _, _, impl): result += <name, impl>;
        case \constructor(name, _, _, impl): result += <name, impl>;
    }

    return(result);
}


public bool aflopend(tuple[&a, num] x, tuple[&a, num] y) {
   return x[1] > y[1];
} 

public map[loc, int] regelsPerBestand (M3 model) {
   set[loc] bestanden = files(model);
   return ( a:size(readFileLines(a)) | a <- bestanden );
}

public rel[str, Statement] methodenAST(tree) {
   rel[str, Statement] result = {};
   visit (tree) {
      case \method(_, name, _, _, impl): result += <name, impl>;
      case \constructor(name, _, _, impl): result += <name, impl>;
   }
   return(result);
}

public int telIfs(Statement d) {
   int count = 0;
   visit(d) {
      case \if(_,_): count=count+1;
      case \if(_,_,_): count=count+1;
   } 
   return count;
}

public void exercise9(){
       loc project = |file:///C:/Users/mspr/Documents/OU/SoftwareQualityManagement/|;
   M3 model = createM3FromDirectory(project);
   set[loc] bestanden = files(model);
  
   // aantal Java-bestanden
   println("(9a)");
   println(size(bestanden));
   
   // aantal regels per Java-bestand
   println("(9b)");
   map[loc, int] regels = regelsPerBestand(model);
   for (<a, b> <- sort(toList(regels), aflopend))
      println("<a.file>: <b> regels");
   
   // aantal methoden per klasse (gesorteerd)
   println("(9c)");
   methoden =  { <x,y> | <x,y> <- model.containment
                       , x.scheme=="java+class"
                       , y.scheme=="java+method" || y.scheme=="java+constructor" 
                       };
   telMethoden = { <a, size(methoden[a])> | a <- domain(methoden) };
   for (<a,n> <- sort(telMethoden, aflopend))
      println("<a>: <n> methoden");
   
   // klasse met meeste subklassen
   println("(9d)");
   subklassen = invert(model.extends);
   telKinderen = { <a, size((subklassen+)[a])> | a <- domain(subklassen) };
   for (<a, n> <- sort(telKinderen, aflopend))
      println("<a>: <n> subklassen");
   
   // klasse met meeste if-statements
   println("(9e)");
   set[Declaration] decls = createAstsFromDirectory(project, true);
   rel[str,Statement] stats = methodenAST(decls);
   aantalIfs = sort([ <name, telIfs(s)> | <name, s> <- stats ], aflopend);
   println(aantalIfs[0]);
}


public void exercise9correct() {

}

public Content exercise10a() {
    loc project = |file:///C:/Users/mspr/Documents/OU/SoftwareQualityManagement/|;
    M3 model = createM3FromDirectory(project);

    rel[str, num] lines = { <l.file, a> | <l,a> <-
    toRel(linesPerFile(model)) };
    
    return barChart(sort(lines, descending), title="Regels per Javabestand");
}

// tip voor opdracht duplicaten
// rascal hashed string onder de motorkap
// string vergelijkingen zijn goedkoop
// + keuze data structuren