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

  def get_markets(params \\ %{}) do
    invoke_public_api("/public/getmarkets?" <> URI.encode_query(params))
  end

  def fee("trade", "maker"), do: 0.25
  def fee("trade", "taker"), do: 0.25
  def fee("deposit", _coin), do: 0
  def fee("withdraw", _coin), do: 0

  def symbols do
    [ "BTC-LTC","BTC-DOGE","BTC-VTC","BTC-PPC","BTC-FTC","BTC-RDD","BTC-NXT","BTC-DASH","BTC-POT","BTC-BLK","BTC-EMC2",
      "BTC-XMY","BTC-AUR","BTC-EFL","BTC-GLD","BTC-SLR","BTC-PTC","BTC-GRS","BTC-NLG","BTC-RBY","BTC-XWC","BTC-MONA",
      "BTC-THC","BTC-ENRG","BTC-ERC","BTC-VRC","BTC-CURE","BTC-XMR","BTC-CLOAK","BTC-START","BTC-KORE","BTC-XDN",
      "BTC-TRUST","BTC-NAV","BTC-XST","BTC-BTCD","BTC-VIA","BTC-PINK","BTC-IOC","BTC-CANN","BTC-SYS","BTC-NEOS",
      "BTC-DGB","BTC-BURST","BTC-EXCL","BTC-SWIFT","BTC-DOPE","BTC-BLOCK","BTC-ABY","BTC-BYC","BTC-XMG","BTC-BLITZ",
      "BTC-BAY","BTC-BTS","BTC-FAIR","BTC-SPR","BTC-VTR","BTC-XRP","BTC-GAME","BTC-COVAL","BTC-NXS","BTC-XCP","BTC-BITB",
      "BTC-GEO","BTC-FLDC","BTC-GRC","BTC-FLO","BTC-NBT","BTC-MUE","BTC-XEM","BTC-CLAM","BTC-DMD","BTC-GAM","BTC-SPHR",
      "BTC-OK","BTC-SNRG","BTC-PKB","BTC-CPC","BTC-AEON","BTC-ETH","BTC-GCR","BTC-TX","BTC-BCY","BTC-EXP","BTC-INFX",
      "BTC-OMNI","BTC-AMP","BTC-AGRS","BTC-XLM","USDT-BTC","BTC-CLUB","BTC-VOX","BTC-EMC","BTC-FCT","BTC-MAID","BTC-EGC",
      "BTC-SLS","BTC-RADS","BTC-DCR","BTC-SAFEX","BTC-BSD","BTC-XVG","BTC-PIVX","BTC-XVC","BTC-MEME","BTC-STEEM","BTC-2GIVE",
      "BTC-LSK","BTC-PDC","BTC-BRK","BTC-DGD","ETH-DGD","BTC-WAVES","BTC-RISE","BTC-LBC","BTC-SBD","BTC-BRX","BTC-ETC",
      "ETH-ETC","BTC-STRAT","BTC-UNB","BTC-SYNX","BTC-TRIG","BTC-EBST","BTC-VRM","BTC-SEQ","BTC-XAUR","BTC-SNGLS","BTC-REP",
      "BTC-SHIFT","BTC-ARDR","BTC-XZC","BTC-NEO","BTC-ZEC","BTC-ZCL","BTC-IOP","BTC-GOLOS","BTC-UBQ","BTC-KMD","BTC-GBG",
      "BTC-SIB","BTC-ION","BTC-LMC","BTC-QWARK","BTC-CRW","BTC-SWT","BTC-TIME","BTC-MLN","BTC-ARK","BTC-DYN","BTC-TKS",
      "BTC-MUSIC","BTC-DTB","BTC-INCNT","BTC-GBYTE","BTC-GNT","BTC-NXC","BTC-EDG","BTC-LGD","BTC-TRST","ETH-GNT","ETH-REP",
      "USDT-ETH","ETH-WINGS","BTC-WINGS","BTC-RLC","BTC-GNO","BTC-GUP","BTC-LUN","ETH-GUP","ETH-RLC","ETH-LUN","ETH-SNGLS",
      "ETH-GNO","BTC-APX","BTC-TKN","ETH-TKN","BTC-HMQ","ETH-HMQ","BTC-ANT","ETH-TRST","ETH-ANT","BTC-SC","ETH-BAT",
      "BTC-BAT","BTC-ZEN","BTC-1ST","BTC-QRL","ETH-1ST","ETH-QRL","BTC-CRB","ETH-CRB","ETH-LGD","BTC-PTOY","ETH-PTOY",
      "BTC-MYST","ETH-MYST","BTC-CFI","ETH-CFI","BTC-BNT","ETH-BNT","BTC-NMR","ETH-NMR","ETH-TIME","ETH-LTC","ETH-XRP",
      "BTC-SNT","ETH-SNT","BTC-DCT","BTC-XEL","BTC-MCO","ETH-MCO","BTC-ADT","ETH-ADT","BTC-FUN","ETH-FUN","BTC-PAY",
      "ETH-PAY","BTC-MTL","ETH-MTL","BTC-STORJ","ETH-STORJ","BTC-ADX","ETH-ADX","ETH-DASH","ETH-SC","ETH-ZEC","USDT-ZEC",
      "USDT-LTC","USDT-ETC","USDT-XRP","BTC-OMG","ETH-OMG","BTC-CVC","ETH-CVC","BTC-PART","BTC-QTUM","ETH-QTUM","ETH-XMR",
      "ETH-XEM","ETH-XLM","ETH-NEO","USDT-XMR","USDT-DASH","ETH-BCC","USDT-BCC","BTC-BCC","BTC-DNT","ETH-DNT","USDT-NEO",
      "ETH-WAVES","ETH-STRAT","ETH-DGB","ETH-FCT","ETH-BTS","USDT-OMG","BTC-ADA","BTC-MANA","ETH-MANA","BTC-SALT","ETH-SALT",
      "BTC-TIX","ETH-TIX","BTC-RCN","ETH-RCN","BTC-VIB","ETH-VIB","BTC-MER","BTC-POWR","ETH-POWR","BTC-BTG","ETH-BTG",
      "USDT-BTG","ETH-ADA","BTC-ENG","ETH-ENG"]
    |> Enum.map(fn (pair) ->
      [coin, base] = String.split(pair, "-")
      "#{base}#{coin}"
    end)
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
