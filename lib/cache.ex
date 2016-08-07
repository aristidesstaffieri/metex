defmodule Metex.Cache do
  use GenServer

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  #Client

  def write(pid, key, val) do
    GenServer.call(pid, {:update, {key, val}})
  end

  #Server

  def handle_call({:update, {key, val}}, _from, cache) do
    new_cache = update_cache(key, val, cache)
    {:reply, new_cache, new_cache}
  end

  def update_cache(key, val, old_cache) do
    case Map.has_key?(old_cache, key) do
      true ->
        :error
      false ->
        Map.put_new(old_cache, key, val)
   end
  end

end


# {:ok, pid} = Metex.Cache.start_link
