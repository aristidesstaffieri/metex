defmodule Metex.PingPong do

  def loop do
    receive do
      {sender_pid, :ping} ->
        send(sender_pid, ping(:ping))
      {sender_pid, :pong} ->
        send(sender_pid, pong(:pong))
      _ ->
        IO.puts "don't know how to process this message"
    end
    loop
  end

  defp ping(arg) do
    receive do
      :ping ->
        IO.puts "ping"
      _ ->
        IO.puts "Did you mean ping?"
    end
  end

  defp pong(arg) do
    receive do
      :pong ->
        IO.puts "pong"
      _ ->
        IO.puts "Did you mean pong?"
    end
  end

  def pp(arg) do
    ping_worker = spawn(Metex.PingPong, :ping, [])
    pong_worker = spawn(Metex.PingPong, :pong, [])

    if arg == :ping do
      send ping_worker, ping(arg)
    else
      send pong_worker, pong(arg)
    end
  end

end
