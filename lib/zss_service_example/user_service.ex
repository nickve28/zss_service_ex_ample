defmodule ZssServiceExample.UserService do
  alias ZssClient.Client

  def get(%{"id" => id}, message) do
    client = auth_client
    payload = %{"user_id" => id}
    options = Map.take(message, [:headers])

    Client.call(client, {"authorize", payload, options})

    response = case Client.get_response(client) do
      {:error, payload, code} when code == 403 -> {:ok, payload, code}
      {:error, payload, code} -> {:ok, %{}, 500}
      _ -> {:ok, fake_user(id), 200}
    end

    response
  end

  def get(_, _) do
    errors = %{
      "validation_errors" => %{
        "id" => "required"
      }
    }
    {:ok, errors, 400}
  end

  defp fake_user(id) do
    %{
      id: id,
      name: "Foo"
    }
  end

  defp auth_client do
    case Process.whereis(ZssServiceExample.Clients.Auth) do
      nil ->
        {:ok, client} = ZssClient.get_config(%{sid: "AUTH", identity: "USER"})
        |> ZssClient.get_client
        Process.register(client, ZssServiceExample.Clients.Auth)

        client
      pid -> pid
    end
  end
end