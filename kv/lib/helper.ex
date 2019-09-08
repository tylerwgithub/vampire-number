defmodule KV.Helper do
  def gencaller(registry, [head | tail]) do
    {:ok, vp} = GenServer.call(registry, {:vampire, head})
    gencaller(registry, tail)
  end

  def gencaller(registry, []) do
    []
  end
end