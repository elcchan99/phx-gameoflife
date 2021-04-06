defmodule Gameoflife.Game.Seeder do
  @callback default_ref_index(Tuple.t(Number.t(), Number.t())) :: Number.t()

  @callback indexes_at(Tuple.t(), Number.t()) :: [Number.t()]

  def apply(implementation, state, {_, _} = dimension, ref_index) do
    implementation.indexes_at(dimension, ref_index)
    |> set_indexes_state_value(state, :live)
  end

  def apply(implementation, state, {_, _} = dimension) do
    IO.inspect(implementation)
    ref_index = implementation.default_ref_index(dimension)
    apply(implementation, state, dimension, ref_index)
  end

  defp set_indexes_state_value(indexes, state, value) do
    indexes |> Enum.reduce(state, fn i, acc -> Map.put(acc, i, value) end)
  end
end
