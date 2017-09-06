defmodule ProblemA do
  @moduledoc """
  ProblemA.
  """

  @doc """
  Start Agent with map as state.
  """
  def start_link(map) when is_map(map) do
    Agent.start_link(fn() -> map end)
  end

  @doc """
  Fetch a value from the agent.
  """
  def fetch!(agent, key) do
    case Agent.get(agent, &fetch_key(&1, key)) do
      {:ok, value} ->
        value
      {:error, err} ->
        raise err
    end
  end

  def fetch_key(map, key) do
    try do
      Map.fetch!(map, key)
    rescue
      err in [KeyError] ->
        {:error, err}
    else
      value ->
        {:ok, value}
    end
  end
end
