defmodule TreeNode do
  defstruct x:0, y:0, key:nil, val:nil, left:nil, right: nil

  def tree(x, y, key, val, left, right) do
    %TreeNode(x: x,y: y, key: key, val: val, left: left, right: right)

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

    av =
      ( :a, 111,
         ( :b, 55,
           ( :x, 100,
             ( :z, 56,nil,nil),
             ( :w, 23,nil,nil)
           ),
           ( :y, 105,
           nil,
            ( :r, 77,nil,nil)
          )
         ),
         ( :c, 123,
            ( :d, 119,
              ( :g, 44,nil,nil),
              ( :h, 50,
                ( :i, 5,nil,nil),
                ( :j, 6,nil,nil)
              )
            ),
            ( :e, 133,nil,nil)
         )
      )
