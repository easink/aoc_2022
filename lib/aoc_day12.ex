defmodule AoC.Day12 do
  @moduledoc false

  @infinity 1_000_000

  def part1(filename) do
    filename
    |> parse()
    |> dijkstra()
    |> then(fn {graph, dist} ->
      destination = find_destination(graph)
      dist[destination]
    end)
  end

  def part2(filename) do
    filename
    |> parse()
    |> dijkstra_part2()
    |> then(fn {graph, dist} ->
      graph
      |> Map.filter(fn {_pos, val} -> val == ?a end)
      |> Map.keys()
      |> Enum.map(fn pos -> dist[pos] end)
      |> Enum.min()
    end)
  end

  def dijkstra(graph) do
    verticies = Map.keys(graph)
    source = find_source(graph)
    graph = Map.put(graph, source, ?a)

    distance = Enum.reduce(verticies, %{}, fn vertex, acc -> Map.put(acc, vertex, @infinity) end)
    distance = Map.put(distance, source, 0)

    previous = Enum.reduce(verticies, %{}, fn vertex, acc -> Map.put(acc, vertex, :undefined) end)
    priority_queue = verticies

    {dist, _prev} = dijkstra_traverse({distance, previous}, priority_queue, graph)
    {graph, dist}
  end

  defp dijkstra_traverse({distance, previous}, [], _graph), do: {distance, previous}

  defp dijkstra_traverse({distance, previous}, priority_queue, graph) do
    vertex_min = Enum.min_by(priority_queue, fn vertex -> distance[vertex] end)
    priority_queue = List.delete(priority_queue, vertex_min)

    vertex_neighbours(vertex_min, priority_queue)
    |> Enum.reduce({distance, previous}, fn neighbour, {distance_acc, previous_acc} ->
      temp_distance = distance_acc[vertex_min] + get_distance(graph, vertex_min, neighbour)

      if temp_distance < distance_acc[neighbour] do
        distance_acc = Map.put(distance_acc, neighbour, temp_distance)
        previous_acc = Map.put(previous_acc, neighbour, vertex_min)

        {distance_acc, previous_acc}
      else
        {distance_acc, previous_acc}
      end
    end)
    |> dijkstra_traverse(priority_queue, graph)
  end

  def dijkstra_part2(graph) do
    verticies = Map.keys(graph)
    source = find_destination(graph)
    graph = Map.put(graph, source, ?z)

    distance = Enum.reduce(verticies, %{}, fn vertex, acc -> Map.put(acc, vertex, @infinity) end)
    distance = Map.put(distance, source, 0)

    previous = Enum.reduce(verticies, %{}, fn vertex, acc -> Map.put(acc, vertex, :undefined) end)
    priority_queue = verticies

    {dist, _prev} = dijkstra_traverse_part2({distance, previous}, priority_queue, graph)
    {graph, dist}
  end

  defp dijkstra_traverse_part2({distance, previous}, [], _graph), do: {distance, previous}

  defp dijkstra_traverse_part2({distance, previous}, priority_queue, graph) do
    vertex_min = Enum.min_by(priority_queue, fn vertex -> distance[vertex] end)
    priority_queue = List.delete(priority_queue, vertex_min)

    vertex_neighbours(vertex_min, priority_queue)
    |> Enum.reduce({distance, previous}, fn neighbour, {distance_acc, previous_acc} ->
      temp_distance = distance_acc[vertex_min] + get_distance_part2(graph, vertex_min, neighbour)

      if temp_distance < distance_acc[neighbour] do
        distance_acc = Map.put(distance_acc, neighbour, temp_distance)
        previous_acc = Map.put(previous_acc, neighbour, vertex_min)

        {distance_acc, previous_acc}
      else
        {distance_acc, previous_acc}
      end
    end)
    |> dijkstra_traverse_part2(priority_queue, graph)
  end

  defp vertex_neighbours({x, y} = _vertex, priority_queue) do
    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
    |> Enum.filter(fn neighbour -> neighbour in priority_queue end)
  end

  defp get_distance(graph, source, destination) do
    a = Map.get(graph, source)
    b = Map.get(graph, destination)

    b = if b == ?E, do: ?z, else: b

    cond do
      a >= b -> 1
      a + 1 == b -> 1
      true -> @infinity
    end
  end

  defp get_distance_part2(graph, source, destination) do
    a = Map.get(graph, destination)
    b = Map.get(graph, source)

    b = if b == ?S, do: ?a, else: b

    cond do
      a >= b -> 1
      a + 1 == b -> 1
      true -> @infinity
    end
  end

  defp parse(filename) do
    filename
    |> File.stream!()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {x_line, y_index}, acc ->
      x_line
      |> String.trim()
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {<<value>>, x_index}, x_acc ->
        Map.put(x_acc, {x_index, y_index}, value)
      end)
    end)
  end

  defp find_source(map) do
    Enum.find(map, fn {_k, v} -> v == ?S end)
    |> elem(0)
  end

  defp find_destination(map) do
    Enum.find(map, fn {_k, v} -> v == ?E end)
    |> elem(0)
  end
end
