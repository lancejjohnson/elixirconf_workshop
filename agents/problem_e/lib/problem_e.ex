defmodule ProblemE do
  @moduledoc """
  Documentation for ProblemE.
  """
  use GenServer


  def pop(key) do
    case GenServer.whereis(__MODULE__) do
      nil -> 0
      _   -> GenServer.call(__MODULE__, {:pop, key})
    end
  end

  def incr(key) do
    case GenServer.whereis(__MODULE__) do
      nil ->
        start_link()
        incr(key)
      _ ->
        GenServer.call(__MODULE__, {:incr, key})
    end
  end

  # only change code above

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, [name: __MODULE__])
  end

  def handle_call({:incr, key}, _from,  state) do
    {:reply, :ok, Map.update(state, key, 1, &(&1 + 1))}
  end

  def handle_call({:pop, key}, _from, state) do
    {val, state} = Map.pop(state, key, 0)
    if state == %{} do
      {:stop, :normal, val, state}
    else
      {:reply, val, state}
    end
  end
end
