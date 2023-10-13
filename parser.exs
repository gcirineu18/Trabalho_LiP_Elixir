
defmodule Parser do
   def isIdent(x)  do
    if is_atom(x) do
     true
    else
    false
    end
   end

  def id(s1) do
    case s1 do
      [x|sn] ->
        if isIdent(x) == true  do
          {x, sn}
        end
    end

  end

 def cop(y) when y in ['<', '>', '<=', '>=', '==', '!='] do
   true
 end

 def eop(y) when y in ['+', '-'] do
   true
 end

 def top(y) when y in ['*', '/'] do
  true
end

def fact(s1, term, eop) do
    case s1 do
      [t|s2] ->
        if is_integer(t) || isIdent(t) do
         sn  = s2
          {t,sn}
        else

        case s1 do
          ['('|^s2] ->
          e = s3 = expr(s2,term, eop)
          case s3 do
            [')'|sn] ->
              {e,sn}
          end

        end
        end
    end
  end

 def term(s1) do

  

  sequence(fact, top, s1)
 end

def expr(s1) do
  sequence(term, eop, s1)
 end

def comp(s1) do
 sequence(expr, cop, s1)
end



def sequence(nonTerm, sep, s1) do

  x1 = nonTerm.(s1)
  case x1 do
    [t|s3] ->
      if sep.(t) do
        x2 = sequence(nonTerm, sep, s3)
        [x1|x2]
      else
        x1
      end
  end
end


def stat(s1) do
    case s1 do
     [t|s2]->
      case t do
       :begin->
        sequence((_stat = fn x -> x==';'end ),'end', s2 )

        :if ->
          s3 = comp(s2)
          case s3 do
           ['then'|s4] ->
             x1 = stat(s4)


          case x1 do
           ['else'|s5] ->
            x2 = stat(s5)

           {'if',x1, x2}
          end
          end
      end
    end
end




end
