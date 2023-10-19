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

def fact(s1) do
   case s1 do
     [t|s2] ->
       if is_integer(t) || isIdent(t) do

         {t,s2}
       else

       case s1 do
         ['('|^s2] ->
         {e ,s3} = expr(s2)
         case s3 do
           [')'|s4] ->
             {e,s4}
         end

       end
       end
   end
 end

def term(s1) do

 sequence(&fact/1, &top/1, s1)
end

def expr(s1) do
 sequence(&term/1, &eop/1, s1)
end

def comp(s1) do
sequence(&expr/1, &cop/1, s1)
end



def sequence(nonTerm, sep, s1) do

 x1 = nonTerm.(s1)
IO.inspect(nonTerm)
 case x1 do
   [t|s2] ->
     if sep.(t) do

       x2 = sequence(nonTerm, sep, s2)
       {x1,x2}
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

     :while ->
       s3 = comp(s2)
       case s3 do
         ['do'|s4] ->
           x = stat(s4)
           {:while, x}
       end
      :read ->
       i = id(s2)
       {:read, i}

      :write ->
        e = expr(s2)
        {:write,e}
    end
  end
   [t|s2] = s1
      if isIdent(t) do
           case s2 do
             [':='|s3]->
               e = expr(s3)
               {:assign, t, e}
             _ ->
              raise "ERROR"
           end
      end
end



def prog(s1) do
  case s1 do
    [:program | s2] ->
      {y, s3} = id(s2)
      case s3 do
        [';' | s4] ->
          {z, s5} = stat(s4)
          case s5 do
            ['end' | _sn] ->
              {:prog, y, z}
            _ ->
              raise "Missing 'end' keyword"
          end
        _ ->
          raise "Missing ';' after program name"
      end
    _ ->
      raise "Invalid program start"
  end
end

end


p = Parser.prog([:program,:foo, ';',:while, :a ,'+' ,3 ,'<', :b ,'do', :b ,':=', :b, '+', 1, 'end'])

IO.puts(p)
