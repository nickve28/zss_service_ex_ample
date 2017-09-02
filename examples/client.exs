{:ok, client} = ZssClient.get_config(%{identity: "EXAMPLE_CLIENT", sid: "USER"})
|> ZssClient.get_client

#Authorized
options = %{
  headers: %{
    "user_id": "1"
  }
}

payload = %{"id" => "1"}

IO.puts "Creating authorized call, calling user 1 as user 1"
ZssClient.Client.call(client, {"get", payload, options})
{indicator, payload, code} = ZssClient.Client.get_response(client)
IO.inspect("Received reply #{inspect payload} with indicator #{indicator} and status #{code}")

#Unauthorized
options = %{
  headers: %{
    "user_id": "1"
  }
}

payload = %{"id" => "2"}

IO.puts "Creating unauthorized call, calling user 2 as user 1"
ZssClient.Client.call(client, {"get", payload, options})
{indicator, payload, code} = ZssClient.Client.get_response(client)
IO.inspect("Received reply #{inspect payload} with indicator #{indicator} and status #{code}")