defmodule AoC.Day21 do
  @moduledoc false

  def part1(p1_pos, p2_pos) do
    train({0, p1_pos}, {0, p2_pos}, 1, 0, :player1)
  end

  def part2(p1_pos, p2_pos) do
    play({0, p1_pos}, {0, p2_pos}, %{}, :player1)
    |> then(fn {{p1, p2}, _cache} -> max(p1, p2) end)
  end

  def play(_current_player, {p_score, _p_pos}, cache, :player2)
      when p_score >= 21,
      do: {{1, 0}, cache}

  def play(_current_player, {p_score, _p_pos}, cache, :player1)
      when p_score >= 21,
      do: {{0, 1}, cache}

  def play(current_player, next_player, cache, player) do
    case cache[{current_player, next_player, player}] do
      nil ->
        play_multi(current_player, next_player, cache, player)
        |> update_cache(current_player, next_player, player)

      wins ->
        {wins, cache}
    end
  end

  def play_multi({p_score, p_pos}, next_player, wins_cache, player) do
    for(i <- 1..3, j <- 1..3, k <- 1..3, do: i + j + k)
    |> Enum.reduce({{0, 0}, wins_cache}, fn score, {wins_acc, wins_cache_acc} ->
      new_pos = move_pawn(p_pos, score)
      current_player = {p_score + new_pos, new_pos}

      play(next_player, current_player, wins_cache_acc, next_player(player))
      |> add_wins(wins_acc)
    end)
  end

  def next_player(:player1), do: :player2
  def next_player(:player2), do: :player1

  def update_cache({wins, cache}, player1, player2, player) do
    updated_cache = Map.put(cache, {player1, player2, player}, wins)
    {wins, updated_cache}
  end

  def add_wins({{p1_wins, p2_wins}, cache}, {p1_tmp_wins, p2_tmp_wins}) do
    {{p1_wins + p1_tmp_wins, p2_wins + p2_tmp_wins}, cache}
  end

  def train({p1_score, _p1_pos}, {p2_score, _p2_pos}, _die, turns, _player)
      when p1_score >= 1000 or p2_score >= 1000 do
    min(p1_score, p2_score) * turns
  end

  def train({p1_score, p1_pos}, player2, die, turns, :player1) do
    {score, next_die} = roll_three(die)
    new_pos = move_pawn(p1_pos, score)
    train({p1_score + new_pos, new_pos}, player2, next_die, turns + 3, :player2)
  end

  def train(player1, {p2_score, p2_pos}, die, turns, :player2) do
    {score, next_die} = roll_three(die)
    new_pos = move_pawn(p2_pos, score)
    train(player1, {p2_score + new_pos, new_pos}, next_die, turns + 3, :player1)
  end

  def roll_three(start) do
    n = 3
    [a, b, c, next] = 1..100 |> Stream.cycle() |> Enum.slice(start - 1, n + 1)
    {a + b + c, next}
  end

  def move_pawn(pos, n) do
    1..10 |> Stream.cycle() |> Enum.take(pos + n) |> List.last()
  end
end
