defmodule ZssServiceExample do
  alias ZssServiceExample.{AuthService, UserService}
  require Logger

  def start do
    config = %{sid: "AUTH"}
    |> ZssService.get_instance
    |> ZssService.add_verb({"authorize", AuthService, :authorize})

    {:ok, pid} = ZssService.run config
    {:ok, pid} = ZssService.run config
    {:ok, pid} = ZssService.run config

    config = %{sid: "USER"}
    |> ZssService.get_instance
    |> ZssService.add_verb({"get", UserService, :get})

    {:ok, pid} = ZssService.run config
    {:ok, pid} = ZssService.run config
    {:ok, pid} = ZssService.run config

    {:ok, client} = ZssClient.get_config(%{sid: "USER", identity: "EXAMPLE_CLIENT"})
    |> ZssClient.get_client
    Process.register(client, ZssServiceExample.ExampleClient)

    loop(client)
  end

  def loop(client) do
    payload = %{id: :random.uniform(2)}
    options = %{headers: %{user_id: :random.uniform(2)}}

    ZssClient.Client.call(client, {"GET", payload, options})
    Task.async(fn ->
      response = ZssClient.Client.get_response(client)
      Logger.warn("Received Response: #{inspect response}")
    end)
    :timer.sleep(:random.uniform(2000))
    loop(client)
  end

end
