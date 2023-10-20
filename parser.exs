

defmodule Parser do

  defmodule IniciaNo do
    defstruct name: nil, left: nil, right: nil

    def new(name, left, right) do
      %IniciaNo{name: name, left: left, right: right}
    end
  end

  defmodule NoEstado do
    defstruct state: nil, operator: nil, left: nil, right: nil

    def new(state, operator, left, right) do
      %NoEstado{state: state, operator: operator, left: left, right: right}
    end
  end


  defmodule NoUnario do
    defstruct state: nil, id: nil

    def new(state, id) do
      %NoUnario{state: state, id: id}
    end
  end


  defmodule NoBinario do
    defstruct operator: nil, left: nil, right: nil

    def new(operator, left, right) do
      %NoBinario{operator: operator, left: left, right: right}
    end
  end
def stat(s1) do
  [t | s2]=s1
  case t do
  :if ->
    {c,s3} = comp(s2)
    [head4 | s4]=s3
    if head4 == :then do
      {x1,s5}=stat(s4)
      [head5 | s6]=s5
      if head5 == :else do
        {x2,sn}=stat(s6)
        {NoEstado.new(:if, c, x1, x2), sn}
      else
        {NoBinario.new(:if, c, x1), s5}
      end
    end

  :while ->
    {c, s3} = comp(s2)
    [head6|s4] = s3
    if head6 == :do do
      {x,sn} = stat(s4)
      {NoBinario.new(:while, c, x), sn}
    end

  :read ->
    {resul,i,sn} = id(s2)
    if resul do
      {NoUnario.new(:read, i), sn}
    end

  :write ->
    {e,sn} = expr(s2)
    {NoUnario.new(:read, e), sn}

  _ ->
    if isIdent(t) do
      [head7|s3] = s2
      if head7 == ':=' do
        {e, sn} = expr(s3)
        {NoBinario.new(':=', t, e), sn}
      else
        raise "token não identificado"
      end
    end
  end
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
           [')'|sn] ->
             {e,sn}
         end

       end
       end
   end
 end


def prog(s1) do

  case s1 do
    [:program | s2] ->
      ergebnis = id(s2)
      if elem(ergebnis,0) or not isIdent(elem(ergebnis,1) ) do
        y = elem(ergebnis,1)
        s3 = elem(ergebnis,2)
        case s3 do
        [';' | s4] ->
          {z, s5} = stat(s4)
          case s5 do
            ['end' | sn] ->
              {IniciaNo.new(:program, y, z), sn}

      end
     end
    end
  end
end


  def isIdent(x)  do
   if ist_atom(x) do
    true
   else
   false
   end
  end

  def ist_atom(x) do
    Enum.member?([';', :if, :while, :read, :write, :do, ':='], x) or is_atom(x)
  end

 def id(s1) do
   case s1 do
     [x|sn] ->
       if isIdent(x) == true  do
         {true,x, sn}
       else
        {false,x, sn}
       end
   end

 end


 def cop(y) do
  y == '<' or y == '>' or y == '=<' or
  y == '>' or y == '==' or y == '!='
end

def eop(y) do
  y == '+' or y == '-'
end

def top(y) do
  y == '*' or y == '/'
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

 {x1,s2} = nonTerm.(s1)

 case s2 do
   [t|s3] ->
     if sep.(t) do

       {x2,sn} = sequence(nonTerm, sep, s3)
       {NoBinario.new(t, x1, x2), sn}
     else
       {x1, s2}
     end
 end
end

end




program2 = [:program,'foo', ';', :while, :a, '+', 3, '<', :b, :do, :b, ':=', :b, '+', 1, 'end']
program1 = [:program, 'progName', ';', :if, :b, '<', 3, :then, :x, ':=', 1, '+', 54, :else, :x, ':=', 1, 'end']

{syntatic,_sn} = Parser.prog(program1)
IO.inspect(syntatic)
