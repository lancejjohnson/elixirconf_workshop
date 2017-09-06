defmodule ProblemC do
  @moduledoc """
  ProblemC.
  """

  @doc """
  Stop a GenServer. Expects GenServer to stop with reason `reason` on receiving
  call `{:stop, reason}`. GenServer should reply with message `:ok`.
  """
  def stop(pid) do
    ref = Process.monitor(pid)
    GenServer.call(pid, {:stop, :normal}, :infinity)
    receive do
      {:DOWN, ^ref, _, _, _} -> :ok
    end
  end
end
