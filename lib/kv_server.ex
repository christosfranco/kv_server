# lib/kv_server.ex
defmodule KvServer do
  use GenServer

  ## Client API

  def start_link(init_arg) do
    GenServer.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  def put(key, value) do
    GenServer.call(__MODULE__, {:put, key, value})
  end

  def get(key) do
    GenServer.call(__MODULE__, {:get, key})
  end

  def get_pid do
    GenServer.call(__MODULE__, :get_pid)
  end

  def poll() do
    GenServer.call(__MODULE__, {:poll})
  end

  # TODO: still fix the polling of state issue.
  # probably not using the same pid
  ## Server Callbacks

  # keep a double map

  # call_id : # participants
  # # partiticipants : count
  # update # participants count by value from call_id map
  # simply return the second map on polling
  def init(_init_arg) do
    IO.inspect("[!] initializing state of kvserver link")
    call_id_map = %{}
    participants_count_map = %{}
    {:ok, { call_id_map , participants_count_map }}
  end


  def handle_call(:get_pid, _from, state) do
    {:reply, self(), state}
  end

  def handle_call({:put, key, value}, _from, state) do
    IO.inspect("[!] handle call")
    # key = call id
    # value = # participants
    {:reply, :ok, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _from, state) do
    {:reply, Map.get(state, key), state}
  end


  def handle_call({:poll}, _from, state) do
    reply = Map. state
    # reply with the aggregation of the map in terms of # participants
    # reset state
    {:reply, reply, %{}}
  end
end
