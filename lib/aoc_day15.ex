defmodule AoC.Day15 do
  @moduledoc """
  could speed up if target found in dijkstra_traverse
  """

  def part1(input) do
    graph = parse(input)
    target = max_coord(graph)

    {distances, _previous} = dijkstra(graph, {0, 0})

    distances[target]

    # |> shortest_path({0, 0}, {2, 2}, [])
  end

  def part2(input) do
    graph =
      input
      |> parse()
      |> fivefold()

    target = max_coord(graph)

    {distances, _previous} = dijkstra(graph, {0, 0})

    distances[target]
  end

  def dijkstra(graph, source) do
    verticies = Map.keys(graph)

    distance = Enum.reduce(verticies, %{}, fn vertex, acc -> Map.put(acc, vertex, :infinity) end)
    distance = Map.put(distance, source, 0)

    previous = Enum.reduce(verticies, %{}, fn vertex, acc -> Map.put(acc, vertex, :undefined) end)
    priority_queue = verticies

    dijkstra_traverse({distance, previous}, priority_queue, graph)
  end

  def dijkstra_traverse({distance, previous}, [], _graph), do: {distance, previous}

  def dijkstra_traverse({distance, previous}, priority_queue, graph) do
    vertex_min = Enum.min_by(priority_queue, fn vertex -> distance[vertex] end)
    priority_queue = Enum.filter(priority_queue, fn vertex -> vertex != vertex_min end)

    vertex_neighbours(vertex_min, graph, priority_queue)
    |> Enum.reduce({distance, previous}, fn neighbour, {distance_acc, previous_acc} ->
      temp_distance = distance_acc[vertex_min] + graph[neighbour]

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

  def vertex_neighbours({x, y} = _vertex, graph, priority_queue) do
    [{x - 1, y}, {x + 1, y}, {x, y - 1}, {x, y + 1}]
    |> Enum.filter(fn neighbour -> neighbour in priority_queue and Map.get(graph, neighbour) end)
  end

  # not needed
  def shortest_path({_distance, _previous}, source, source, path), do: Enum.reverse(path)

  def shortest_path({distance, previous}, source, target, path) do
    shortest_path({distance, previous}, source, previous[target], [target | path])
  end

  def parse(input) do
    input
    |> String.split()
    |> Enum.with_index()
    |> Enum.reduce(%{}, fn {x_line, y_index}, acc ->
      x_line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.reduce(acc, fn {value, x_index}, x_acc ->
        Map.put(x_acc, {x_index, y_index}, String.to_integer(value))
      end)
    end)
  end

  def fivefold(graph) do
    {max_x, max_y} = max_coord(graph)
    max_x = max_x + 1
    max_y = max_y + 1

    for(y <- 0..4, x <- 0..4, do: {x, y})
    |> Enum.reduce(%{}, fn {x_a, y_a}, acc ->
      Enum.reduce(graph, acc, fn {{x, y}, weight}, macc ->
        weight = weight + x_a + y_a

        weight =
          cond do
            weight < 10 -> weight
            weight < 19 -> weight - 9
            weight < 28 -> weight - 18
          end

        Map.put(macc, {x + max_x * x_a, y + max_y * y_a}, weight)
      end)
    end)
  end

  def max_coord(graph) do
    graph
    |> Map.keys()
    |> Enum.reduce({0, 0}, fn {a, b}, {x, y} -> {max(a, x), max(b, y)} end)
  end
end
