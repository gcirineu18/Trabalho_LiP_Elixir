
# Algoritmo para implementar
# o desenho da Árvore Binária
# Dupla:
# Bruna Gomes Carneiro : 537993
# Guilherme Barbosa Cirineu : 520404

defmodule TreeNode do
  defstruct x:0, y:0, key:nil, val:nil, left:nil, right: nil

  def tree(x, y, key, val, left, right) do
    %TreeNode(x: x,y: y, key: key, val: val, left: left, right: right)


  tree =
    tree(0, 0, :a, 111,
       tree(0, 0, :b, 55
         tree(0, 0, :x, 100,
           tree(0, 0, :z, 56, %TreeNode{},%TreeNode{}),
           tree(0, 0, :w, 23, %TreeNode{},%TreeNode{}),
         ),
       tree(0, 0, :y, 105,
          %TreeNode{},
          tree(0, 0, :r, 77, %TreeNode{},%TreeNode{})

        )
       ),
       tree(0, 0, :c, 123,
          tree(0, 0, :d, 119,
            tree(0, 0, :g, 44, %TreeNode{},%TreeNode{}),
            tree(0, 0, :h, 50,
              tree(0, 0, :i, 5, %TreeNode{}, %TreeNode{}),
              tree(0, 0, :j, 6, %TreeNode{}, %TreeNode{})
            )
          ),
          tree(0, 0, :e, 133, %TreeNode{}, %TreeNode{})
       )
    )
