defmodule TreeNode do
  defstruct key: 0, val: 0, left: nil, right: nil

  def tree(key, val, left, right) do
    %TreeNode{key: key, val: val, left: left, right: right}
  end
end

defmodule DepthFirst do
  @scale 30

  def depthFirst(nil, _level, _leftLim) do
    {nil, 0.0}
  end

  def depthFirst(%TreeNode{key: key, val: val, left: nil, right: nil}, level, leftLim) do
    y = @scale * level
    x = root_x = rightLim = leftLim
    IO.inspect({ %{key: key, val: val}, x, y })
    {root_x, rightLim}
  end

  def depthFirst(%TreeNode{key: key, val: val, left: l, right: nil}, level, leftLim) do
    { root_x, rightLim} = depthFirst(l, level + 1, leftLim)
    y = @scale * level
    x = root_x
    IO.inspect({ %{key: key, val: val}, x, y })
    { root_x, rightLim}
  end

  def depthFirst(%TreeNode{key: key, val: val, left: nil, right: r}, level, leftLim) do
    {root_x, rightLim} = depthFirst(r, level + 1, leftLim)
    y = @scale * level
    x = root_x
    IO.inspect({ %{key: key, val: val}, x, y })
    {root_x, rightLim}
  end

  def depthFirst(%TreeNode{key: key, val: val, left: l, right: r}, level, leftLim) do
    y = @scale * level
    {lroot_x, lrightLim} = depthFirst(l, level + 1, leftLim)

    #IO.inspect({lroot_x, lrightLim})
    rleftLim = lrightLim + @scale
    {rroot_x, rrightLim} = depthFirst(r, level + 1, rleftLim)


       x = (rroot_x + lroot_x) / 2




    IO.inspect({ %{key: key, val: val}, x, y })
    {x, rrightLim}
  end
end

# Define the tree
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

# Call the depthFirst function
DepthFirst.depthFirst(tree, 1, 30)
