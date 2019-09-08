defmodule KV.Registry do
  use GenServer

  ## Missing Client API - will add this later
  ## Client API

  @doc """
  Starts the registry.
  """
  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  Returns `{:ok, pid}` if the bucket exists, `:error` otherwise.
  """
  def vampire(server, nums) do
    GenServer.call(server, {:vampire, nums})
  end

  ## Defining GenServer Callbacks

  @impl true
  def init(:ok) do
    {:ok, []}
  end

  @impl true
  def handle_call({:vampire, nums}, _from, names) do
    {:ok, bucket} = KV.Bucket.start_link(nums)
    list = KV.Bucket.cal(bucket)
    Enum.each(list, fn row -> printRow(row) end)
    names = [names | list]
    # Enum.each(names, fn row -> printRow(row) end)

    {:reply, {:ok, names}, names}
  end

  @impl true
  def handle_cast({:vampire, nums}, names) do
    # Enum.each(names, fn row -> printRow(row) end)
    {:noreply, Enum.each(names, fn row -> printRow(row) end)}
  end

  defp printRow(row) do
    Enum.each(row, fn item -> IO.write item; IO.write " " end)
    IO.puts ""
  end

end