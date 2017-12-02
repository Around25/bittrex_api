defmodule BittrexApi do
  @moduledoc """
  Documentation of all the API calls and the corresponding parameters.
  """

  @doc """
  Get ticker information

  Param:
  - market = comma delimited list of asset pairs to get info on
  """
  def get_ticker(params \\ %{}) do
    invoke_public_api("/public/getticker?" <> URI.encode_query(params))
  end

  @doc """
  Get order book

  Params:
  - market = asset pair to get market depth for
  - type = asks | bids | both

  Response:
  {
    "success" : true,
    "message" : "",
    "result" : {
      "buy" : [{
        "Quantity" : 12.37000000,
        "Rate" : 0.02525000
      }],
      "sell" : [{
        "Quantity" : 32.55412402,
        "Rate" : 0.02540000
      }, {
        "Quantity" : 60.00000000,
        "Rate" : 0.02550000
      }, {
        "Quantity" : 60.00000000,
        "Rate" : 0.02575000
      }, {
        "Quantity" : 84.00000000,
        "Rate" : 0.02600000
      }]
    }
  }

  """
  def get_order_book(params \\ %{}) do
    invoke_public_api("/public/getorderbook?" <> URI.encode_query(params))
  end

  # Helper method to invoke the public APIs
  # Returns a tuple {status, result}
  defp invoke_public_api(method) do
    query_url = Application.get_env(:bittrex_api, :api_endpoint) <> "/" <> Application.get_env(:bittrex_api, :api_version) <> method

    case HTTPoison.get(query_url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, Poison.decode!(body)}
      # Try to get and display the error message from Exchange.
      {:ok, %HTTPoison.Response{status_code: _, body: body}} -> {:error, Poison.decode!(body)}
      # Otherwise just error
      err -> {:error, err}
    end
  end

#  defp invoke_private_api(method, params, nonce \\ DateTime.utc_now() |> DateTime.to_unix(:millisecond) |> to_string) do
#    post_data = Map.merge(params, %{"nonce": nonce})
#    path = "/" <> Application.get_env(:kraken_api, :api_version) <> "/private/" <> method
#    query_url = Application.get_env(:kraken_api, :api_endpoint) <> path
#
#    signed_message = sign(path, post_data, Application.get_env(:kraken_api, :private_key), nonce)
#
#    # Transform the data into list-of-tuple format required by HTTPoison.
#    post_data = Enum.map(post_data, fn({k, v}) -> {k, v} end)
#    case HTTPoison.post(query_url,
#           {:form, post_data},
#           [{"API-Key", Application.get_env(:kraken_api, :api_key)}, {"API-Sign", signed_message}, {"Content-Type", "application/x-www-form-urlencoded"}]
#         ) do
#      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
#        body = Poison.decode!(body)
#        {:ok, Map.get(body, "result")}
#      # Try to get and display the error message from Kraken.
#      {:ok, %HTTPoison.Response{status_code: _, body: body}} ->
#        body = Poison.decode!(body)
#        {:error, Map.get(body, "error")}
#      # Otherwise just error
#      err -> {:error, err}
#    end
#  end

  # Function to sign the private request.
  defp sign(path, post_data, private_key, nonce) do
    post_data = URI.encode_query(post_data)
    decoded_key = Base.decode64!(private_key)
    hash_result = :crypto.hash(:sha256, nonce <> post_data)
    :crypto.hmac(:sha512, decoded_key, path <> hash_result) |> Base.encode64
  end

end
