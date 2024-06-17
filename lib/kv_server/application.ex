# lib/kv_server/application.ex
defmodule KvServer.Application do
  use Application

  def start(_type, _args) do
    children = [
      {KvServer, %{}}
    ]
    IO.inspect("[!] Starting app")
    opts = [strategy: :one_for_one, name: KvServer.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
