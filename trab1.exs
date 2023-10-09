
# Algoritmo para implementar
# o desenho da Árvore Binária
# Dupla:
# Bruna Gomes Carneiro : 537993
# Guilherme Barbosa Cirineu : 520404

defmodule TreeNodeXY do

  defstruct x: 0, y: 0, key: nil, val: nil, left: nil, right: nil

  def addXY(x, y, key, val, left, right) do
    %TreeNodeXY{x: x, y: y, key: key, val: val, left: left, right: right}
  end
end

defmodule TreeNode do

  defstruct key: nil, val: nil, left: nil, right: nil

      def tree(key, val, left, right) do
        %TreeNode{key: key, val: val, left: left, right: right}
      end

end

defmodule TreeDrawing do
  # Definir atributo do módulo
  @scale 30

  defmodule TreeCoordinate do
    def depthFirst(tree, level, leftLim, root_x, rightLim)
      case tree do
        %{:tree | key: key, val: val, left: nil, right: nil } ->
          x = root_x= rightLim=leftLim
          y = @scale*level
        # retornando a tupla com o nó e as coordenadas

          { %{key: key, val: val, left: left, right: right}, x,y}

        %{:tree | key: key, val: val, left: l, right: nil } ->
          x=root_x
          y= @scale*level
          depthFirst( l, level+1, leftLim, root_x, rightLim)

        %{:tree | key: key, val: val, left: nil, right: r } ->
          x=root_x
          y= @scale*level
          depthFirst( r, level+1, leftLim, root_x, rightLim)

        %{:tree | key: key, val: val, left: l, right: r } ->
          y=@scale*level
          depthFirst( l, level+1, leftLim, lroot_x, lrightLim)
          rleftLim = rightLim+@scale
          depthFirst( r, level+1, rleftLim, rroot_x, rightLim)
          x=root_x=(lroot_x+rroot_x)/2

    end

  end

end

av =
  TreeNode.tree( :a, 111,
     TreeNode.tree( :b, 55,
       TreeNode.tree( :x, 100,
         TreeNode.tree( :z, 56,nil,nil),
         TreeNode.tree( :w, 23,nil,nil)
       ),
       TreeNode.tree( :y, 105,
       nil,
        TreeNode.tree( :r, 77,nil,nil)
      )
     ),
     TreeNode.tree( :c, 123,
        TreeNode.tree( :d, 119,
          TreeNode.tree( :g, 44,nil,nil),
          TreeNode.tree( :h, 50,
            TreeNode.tree( :i, 5,nil,nil),
            TreeNode.tree( :j, 6,nil,nil)
          )
        ),
        TreeNode.tree( :e, 133,nil,nil)
     )
  )
