defmodule TreeTraversal do
  @scale 30

  def depth_first(tree) do
    depth_first(tree, 1, 30, 0, 0)
  end

  defp depth_first(%{key: key, value: value, left: nil, right: nil}, level, left_lim, _root_x, _right_lim) do
    x = _root_x = _right_lim = left_lim
    y = @scale * level
    [{key, value, x, y}]
  end

  defp depth_first(%{key: key, value: value, left: left, right: nil}, level, left_lim, root_x, right_lim) do
    x = root_x
    y = @scale * level
    [{key, value, x, y} | depth_first(left, level + 1, left_lim, root_x, right_lim)]
  end

  defp depth_first(%{key: key, value: value, left: nil, right: right}, level, left_lim, root_x, right_lim) do
    x = root_x
    y = @scale * level
    [{key, value, x, y} | depth_first(right, level + 1, left_lim, root_x, right_lim)]
  end

  defp depth_first(%{key: key, value: value, left: left, right: right}, level, left_lim, root_x, right_lim) do
    y = @scale * level
    [{key, value, l_root_x, _l_right_lim} | left_result
] = depth_first(left, level + 1, left_lim, root_x, (left_lim + root_x) / 2)

    [
      {key, value, r_root_x, r_left_lim} | right_result
    ] = depth_first(right, level + 1, (root_x + right_lim) / 2, root_x, right_lim)

    x = (l_root_x + r_root_x) / 2

    [{key, value, x, y} | left_result ++ right_result]
  end
end

tr =
  %{
    key: 1,
    value: "A",
    left: %{key: 2, value: "B", left: nil, right: nil},
    right: %{key: 3, value: "C", left: nil, right: nil}
  }

  tree =
    %{
      key: 1,
      value: "A",
      left: nil,
      right: nil
    }

result = TreeTraversal.depth_first(tree)
IO.inspect(result)