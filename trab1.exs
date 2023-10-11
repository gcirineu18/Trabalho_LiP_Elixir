
# Algoritmo para implementar
# o desenho da Árvore Binária
# Dupla:
# Bruna Gomes Carneiro : 537993
# Guilherme Barbosa Cirineu : 520404


defmodule TreeNode do

  defstruct key: 0, val: 0, left: nil, right: nil

      def tree(key, val, left, right) do
        %TreeNode{key: key, val: val, left: left, right: right}
      end

end

defmodule DepthFirst do
  # Definir atributo do módulo
  @scale 30

  def depthFirst(tree, level, leftLim, root_x, rightLim) when is_map(tree) do
      case tree do
        %TreeNode{key: key, val: val, left: nil, right: nil } ->
          x = root_x= rightLim=leftLim
          y = @scale*level
        # retornando a tupla com o nó e as coordenadas

          { %{key: key, val: val}, x,y}

        %TreeNode{key: key, val: val, left: l, right: nil } ->
          x=root_x
          y= @scale*level
          depthFirst( l, level+1, leftLim, root_x, rightLim)

        %TreeNode{key: key, val: val, left: nil, right: r } ->
          x=root_x
          y= @scale*level
          depthFirst( r, level+1, leftLim, root_x, rightLim)

        %TreeNode{key: key, val: val, left: l, right: r } ->
          y=@scale*level

          lroot_x = 0
          lrightLim=0

          depthFirst( l, level+1, leftLim, lroot_x, lrightLim)

          rleftLim = rightLim+@scale
          rroot_x=0

          depthFirst( r, level+1, rleftLim, rroot_x, rightLim)

          x=root_x=(lroot_x+rroot_x)/2
      end


  end

end

tree =
  %{ :a,111,
     %{ :b, 55,
       %{ :x, 100,
         %{ :z, 56,nil,nil},
         %{ :w, 23,nil,nil}
       },
       %{ :y, 105,
       nil,
        %{ :r, 77,nil,nil}
      }
     },
     %{ :c, 123,
        %{ :d, 119,
          %{ :g, 44,nil,nil},
          %{ :h, 50,
            %{ :i, 5,nil,nil},
            %{ :j, 6,nil,nil}
          }
        },
        %{ :e, 133,nil,nil}
     }
  }

  fun = TreeDrawing.depthFirst(av, 1, 0, 0,0)

  IO.inspect(fun)
