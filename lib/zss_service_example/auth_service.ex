defmodule ZssServiceExample.AuthService do
  def authorize(%{"user_id" => user_id}, %{headers: %{"user_id" => user_id}}) do
    {:ok, true, 200}
  end

  def authorize(%{"user_id" => _}, _headers) do
    errors = %{
      developer_message: "The requesting user is not provided in the headers",
      user_message: "The user is not authorized",
      validation_errors: []
    }
    {:ok, errors, 403}
  end

  def authorize(_, _) do
    errors = %{
      "validation_errors": %{
        "user_id" => "required"
      }
    }
    {:ok, errors, 400}
  end
end