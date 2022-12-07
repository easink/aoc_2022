defmodule AoC.Day07 do
  @moduledoc false

  def part1(filename) do
    filename
    |> parse()
    |> find_small_dir_sizes()
  end

  def part2(filename) do
    filename
    |> parse()
    |> find_smallest_dir_to_delete()
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, " "))
    |> parse_fs([], %{})
  end

  defp find_small_dir_sizes(fs) do
    fs
    |> Map.filter(fn {_dir, size} -> size <= 100_000 end)
    |> Map.values()
    |> Enum.sum()
  end

  defp find_smallest_dir_to_delete(fs) do
    disk_size = 70_000_000
    need = 30_000_000
    used = fs[["/"]]
    min_to_delete = need - (disk_size - used)

    fs
    |> Map.filter(fn {_path, size} -> size >= min_to_delete end)
    |> Map.values()
    |> Enum.sort()
    |> hd
  end

  defp parse_fs([], _cwd, fs), do: fs

  # defp parse_fs([["$", "cd", "/"] | entries], _cwd, fs),
  #   do: parse_fs(entries, [], fs)

  defp parse_fs([["$", "cd", ".."] | entries], [_ | cwd], fs),
    do: parse_fs(entries, cwd, fs)

  defp parse_fs([["$", "cd", dir] | entries], cwd, fs),
    do: parse_fs(entries, [dir | cwd], fs)

  defp parse_fs([["$", "ls"] | entries], cwd, fs),
    do: parse_fs(entries, cwd, fs)

  defp parse_fs([["dir", _dir] | entries], cwd, fs),
    do: parse_fs(entries, cwd, fs)

  defp parse_fs([[size, _file] | entries], cwd, fs) do
    fs = update_dir_size(fs, cwd, String.to_integer(size))
    parse_fs(entries, cwd, fs)
  end

  defp update_dir_size(fs, [], _size), do: fs

  defp update_dir_size(fs, cwd, size) do
    fs
    |> Map.update(Enum.reverse(cwd), size, fn dir_size -> dir_size + size end)
    |> update_dir_size(tl(cwd), size)
  end
end
