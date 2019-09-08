defmodule VampireNumbers do

  # function to print vampire numbers in a list
  def print_vampire_numbers_in_list(input_list) do
    input_list
    |> Task.async_stream(fn number -> vampire_factors(number) end, max_concurrency: 8)
    # remove the :ok returned by the task 
    |> Enum.map(fn {:ok, result} -> result end)
    # if length == 1, the list contains only the number and no vampire factors
    |> Enum.filter(fn list -> length(list) > 1 end)
    # the resultant list will be the number at head, and lists of fangs
    |> Enum.map(fn [head | tail] -> [head] ++ List.flatten(tail) end)
    # print each vampire number and its fangs
    # |> Enum.each(fn row -> printRow(row) end)
    # {:ok}
  end

  # print output in the required format
  defp printRow(row) do
    Enum.each(row, fn item -> IO.write item; IO.write " " end)
    IO.puts ""
  end

  # recursive definition to find factors of a number
  defp factor_pairs_list(n, start), do: factor_pairs_list(n, start, []) |> Enum.sort
  # find factors until square root of the number
  defp factor_pairs_list(n, i, factors) when n < i*i    , do: factors
  defp factor_pairs_list(n, i, factors) when n == i*i   , do: [[i, i] | factors]
  defp factor_pairs_list(n, i, factors) when rem(n,i)==0, do: factor_pairs_list(n, i+1, [[i, div(n,i)] | factors])
  defp factor_pairs_list(n, i, factors)                 , do: factor_pairs_list(n, i+1, factors)
 
  # finds all factor pairs for a number
  def factor_list_util(n) do
    # find factors starting with a potential factor half the length of actual number
    start = trunc(n / :math.pow(10, div(num_of_digits(n), 2)))
    # find all factor pairs
    factor_pairs_list(n, start)
  end
 
  # find vampire factors for a number. Returns empty list in case number is not a vampire number
  def vampire_factors(n) do
    cond do
      # no vampire number with 3 or less digits
      num_of_digits(n) < 4 -> 
        []
      # no vampire number with odd number of digits
      rem(num_of_digits(n), 2) == 1 ->
        []
      true ->
        half = div(num_of_digits(n), 2)
        sorted = Enum.sort(String.codepoints("#{n}"))
        all_factors = Enum.filter(factor_list_util(n), fn [a, b] ->
          # both factors of a vampire number need to have half the number of digits of original number
          num_of_digits(a) == half && num_of_digits(b) == half &&
          # both factors of a vampire number cannot have trailing zeros
          Enum.count([a, b], fn x -> rem(x, 10) == 0 end) != 2 &&
          # all digits in both factors combined should be the digits in the original number
          Enum.sort(String.codepoints("#{a}#{b}")) == sorted
        end)
        [n | all_factors]
    end
  end

  # number of digits in a number
  defp num_of_digits(n), do: length(Kernel.to_charlist(n))
end

#IO.inspect VampireNumbers.factor_pairs_list(245)
#IO.inspect VampireNumbers.factor_pairs(1260)

