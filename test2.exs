defmodule TreeTraversal do
  def depth_first(tree, level, left_lim, root_x, right_lim) when is_map(tree) do
    case tree do
      %{
        key: _,
        value: _,
        left: :leaf,
        right: :leaf
      } ->
        x = root_x
        y = level * 30
        {x, y}

      %{
        key: _,
        value: _,
        left: l,
        right: :leaf
      } ->
        {l_root_x, l_right_lim} = depth_first(l, level + 1, left_lim, root_x, right_lim)
        x = l_root_x
        y = level * 30
        {x, y}

      %{
        key: _,
        value: _,
        left: :leaf,
        right: r
      } ->
        {r_root_x, r_left_lim} = depth_first(r, level + 1, left_lim, root_x, right_lim)
        x = r_root_x
        y = level * 30
        {x, y}

      %{
        key: _,
        value: _,
        left: l,
        right: r
      } ->
        {l_root_x, l_right_lim} = depth_first(l, level + 1, left_lim, root_x, right_lim)
        {r_root_x, r_left_lim} = depth_first(r, level + 1, l_right_lim, root_x, right_lim)
        x = div(l_root_x + r_root_x, 2)
        y = level * 30
        {x, y}
    end
  end
end

tree =
  { :a, 111,
    { :b, 55,
      { :x, 100,
        { :z, 56, nil, nil },
        { :w, 23, nil, nil }
      },
      { :y, 105, nil,
        { :r, 77, nil, nil }
      }
    },
    { :c, 123,
      { :d, 119,
        { :g, 44, nil, nil },
        { :h, 50,
          { :i, 5, nil, nil },
          { :j, 6, nil, nil }
        }
      },
      { :e, 133, nil, nil }
    }
  }

fun = TreeTraversal.depth_first(tree, 1, 0, 0, 0)

IO.inspect(inspect(fun))
