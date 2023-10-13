declare
%main parser call. Returns the parsed output
% S1 -> input list of tokens | Sn -> the rest of the list after parsing
fun {Prog S1 Sn}
    Y Z S2 S3 S4 S5 
in
    S1=program|S2 %S2 -> all the program after the keyword "program"
    Y={Id S2 S3}
    S3=';'|S4
    Z={Stat S4 S5}
    S5='end'|Sn
    prog(Y Z)
end

%parses statements
fun {Stat S1 Sn}
    T|S2=S1 
in
    case T of 
        begin then
            {Sequence Stat fun {$ X} X==';' end S2 'end'|Sn}
        
        [] 'if' then        %"if" statement
            C X1 X2 S3 S4 S5 S6 in 
            {Comp C S2 S3}
            S3='then'|S4
            X1={Stat S4 S5}
            S5='else'|S6
            X2={Stat S6 Sn}
            'if'(C X1 X2)   %returns the record
        
        [] while then       %"while" statement
            C X S3 S4 in 
            C={Comp S2 S3}
            S3='do'|S4
            X={Stat S4 Sn}
            while(C X)      %returns the record
        
        [] read then        %"read" statement
            I in 
            I={Id S2 Sn}
            read(I)         %returns the record
        
        [] write then       %"write" statement
            E in 
            E={Expr S2 Sn}
            write(E)        %returns the record
        
        elseif {IsIdent T} then E S3 in
            S2=':='|S3
            E={Expr S3 Sn}
            assign(T E)     %returns the record
        
        else                %if it doesnt fit to any statement, raises an error
            S1=Sn
            raise error(S1) end
    end
end


%parses statement sequences
%NonTerm -> any nonterminal (function) | Sep -> detects the separator symbol in a sequence
fun {Sequence NonTerm Sep S1 Sn}
    X1 S2 T S3 
in
    X1={NonTerm S1 S2}
    S2=T|S3
    if {Sep T} then 
        X2 in
        X2={Sequence NonTerm Sep S3 Sn}
        T(X1 X2) % Dynamic record creation according to a label that is known only at run time
    else
        S2=Sn
        X1
    end
end


fun {Comp S1 Sn} {Sequence Expr COP S1 Sn} end %parses comparisons
fun {Expr S1 Sn} {Sequence Term EOP S1 Sn} end %parses expressions
fun {Term S1 Sn} {Sequence Fact TOP S1 Sn} end %parses terms
%Each of these three functions has its corresponding function for detecting separators:

fun {COP Y} %checks if it's a comparison operator
    Y=='<' orelse Y=='>' orelse Y=='=<' orelse
    Y=='>=' orelse Y=='==' orelse Y=='!='
end

fun {EOP Y} %checks if it's an expression operator
    Y=='+' orelse Y=='-' 
end

fun {TOP Y} %checks if it's a term operator
    Y=='*' orelse Y=='/'
end
%Finally, factors and identifiers are parsed as follows:
fun {Fact S1 Sn}
    T|S2=S1 
in
    if {IsInt T} orelse {IsIdent T} then %if it's an integer or string
        S2=Sn
        T
    else E S2 S3 in %if it's not, that's because we have parentheses. So, we must parse the expression inside of it
        S1='('|S2
        E={Expr S2 S3}
        S3=')'|Sn
        E
    end
end

fun {Id S1 Sn} %checks if it's an identifier (string)
    X 
in 
    S1=X|Sn 
    true={IsIdent X} 
    X 
end

fun {IsIdent X} 
    {IsAtom X} 
end



declare A Sn in
    A={Prog
    [program foo ';'
    while a '+' 3 '<' b 'do' b ':=' b '+' 1 'end']
    Sn}
{Browse A}