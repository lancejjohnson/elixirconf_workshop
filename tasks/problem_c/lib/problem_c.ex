defmodule ProblemC do
  @moduledoc """
  Handle timeout for an external request.
  """

  def get(timeout) do
    task = Task.async(fn -> slow_request() end)

    case Task.yield(task, timeout) do
      {:ok, _result} = result -> result
      {:exit, reason}         -> {:error, reason}
      nil                     -> :request_timeout
    end
  end

  defp slow_request() do
    HTTPoison.get("https://bbc.com")
  end
end
