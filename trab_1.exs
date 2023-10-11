defmodule TreeNode do
  defstruct key: 0, val: 0, left: nil, right: nil

  def tree(key, val, left, right) do
    %TreeNode{key: key, val: val, left: left, right: right}
  end
end

defmodule DepthFirst do
  @scale 30

  def depthFirst(nil, _level, _leftLim, _root_x, _rightLim) do
    {nil, 0.0, 0.0}
  end

  def depthFirst(%TreeNode{key: key, val: val, left: nil, right: nil}, level, leftLim, _root_x, _rightLim) do
    x = leftLim
    y =@scale * level
    IO.inspect({ %{key: key, val: val}, x, y })
  end
  def depthFirst(%TreeNode{key: key, val: val, left: l, right: nil}, level, leftLim, root_x, rightLim) do
      x = root_x
      y = @scale * level

      IO.inspect({ %{key: key, val: val}, x, y })

      depthFirst(l, level + 1, leftLim, root_x, rightLim)
      #{l_node, root_x, rightLim} = depthFirst(l, level + 1, leftLim, root_x, rightLim)
  end
  def depthFirst(%TreeNode{key: key, val: val, left: nil, right: r}, level, leftLim, root_x, rightLim) do
        x = root_x
        y = @scale * level
        IO.inspect({ %{key: key, val: val}, x, y })

        depthFirst(r, level + 1, leftLim, root_x, rightLim)
        #{r_node, root_x, rightLim} = depthFirst(r, level + 1, leftLim, root_x, rightLim)
  end
  def depthFirst(%TreeNode{key: key, val: val, left: l, right: r}, level, leftLim, root_x, rightLim) do
    y = @scale * level

    {_l_node, lroot_x, lrightLim} =
      if l != nil do
        depthFirst(l, level + 1, leftLim, root_x, rightLim)
      else
        {nil, root_x, root_x}
      end

    rleftLim = lrightLim + @scale
    {_r_node, rroot_x, _} =
      if r != nil do
        depthFirst(r, level + 1, rleftLim, rleftLim, rightLim)
      else
        {nil, rleftLim, rightLim}
      end

    x = (lroot_x + rroot_x) / 2
    IO.inspect({ %{key: key, val: val}, x, y })
    #{ %{key: key, val: val}, x, y }
  end
end

# Correção na definição da árvore
tree =
  TreeNode.tree(:a, 111,
    TreeNode.tree(:b, 55,
      TreeNode.tree(:x, 100,
        TreeNode.tree(:z, 56, nil, nil),
        TreeNode.tree(:w, 23, nil, nil)
      ),
      TreeNode.tree(:y, 105, nil,
        TreeNode.tree(:r, 77, nil, nil)
      )
    ),
    TreeNode.tree(:c, 123,
      TreeNode.tree(:d, 119,
        TreeNode.tree(:g, 44, nil, nil),
        TreeNode.tree(:h, 50,
          TreeNode.tree(:i, 5, nil, nil),
          TreeNode.tree(:j, 6, nil, nil)
        )
      ),
      TreeNode.tree(:e, 133, nil, nil)
    )
  )

# Correção na chamada da função
fun = DepthFirst.depthFirst(tree, 1, 30, 0, 0)

IO.inspect(fun)
