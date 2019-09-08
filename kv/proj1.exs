defmodule Proj1 do
    cl_options = System.argv()
    IO.puts System.schedulers_online
    [start, stop] = cl_options
    {:ok, registry} = GenServer.start_link(KV.Registry, :ok)
    [start, stop] = [String.to_integer(start), String.to_integer(stop)]
    nums = Enum.to_list start..stop
    nums = Enum.chunk_every(nums, 10000)
    KV.Helper.gencaller(registry, nums)
    # {:ok, vp} = GenServer.call(registry, {:vampire, num})
    # {:ok, vp} = GenServer.call(registry, {:vampire, h})
    # GenServer.cast(registry, {:vampire, num})
    # IO.inspect vp



    # cl_options = System.argv()
    # #IO.puts System.schedulers_online
    # [start, stop] = cl_options
    # VampireNumbers.print_vampire_numbers_in_list( Enum.to_list(String.to_integer(start) .. String.to_integer(stop)))
end

# defmodule Helper do
#   def caller([head | tail]) do
#     {:ok, vp} = GenServer.call(registry, {:vampire, head})
#     caller(tail)
#   end

#   def caller([]) do
#     []
#   end
# end