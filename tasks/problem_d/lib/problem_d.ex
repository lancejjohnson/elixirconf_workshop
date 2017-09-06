defmodule ProblemD do
  @moduledoc """
  ProblemD.
  """

  @enforce_keys [:pid, :ref]
  defstruct [:pid, :ref, :owner]

  @doc """
  Start a task and await on the result, as `Task.async`.
  """
  def async(fun) do
    %{owner: owner, pid: pid, ref: ref} = Task.async fun
    %__MODULE__{pid: pid, ref: ref, owner: owner}
  end

  @doc """
  Await the result of a task, as `Task.await`
  """
  def await(%__MODULE__{} = task, timeout) do
    task
    |> to_task
    |> Task.await(timeout)
  end

  @doc """
  Yield to wait the result of a task, as `Task.yield`.
  """
  def yield(task, timeout)

  defp to_task(%__MODULE__{owner: owner, pid: pid, ref: ref}) do
    %Task{owner: owner, pid: pid, ref: ref}
  end
end
