defmodule KV.Bucket do
  use Agent

  @doc """
  Starts a new bucket.
  """
  def start_link(nums) do
    Agent.start_link(fn -> nums end)
  end

  @doc """
  """
  def cal(bucket) do
    # Agent.update(bucket, fn )
    Agent.get(bucket, fn nums -> VampireNumbers.print_vampire_numbers_in_list(nums) end )
    # Agent.stop(bucket)
  end

  

end