defmodule BittrexApi.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bittrex_api,
      version: "0.1.0",
      elixir: "~> 1.4",
      start_permanent: Mix.env == :prod,
      description: description(),
      package: package(),
      deps: deps(),
      name: "bittrex_api",
      source_url: "https://git.cloud.around25.net/startups/trendycoins/bittrex_api"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:httpoison],
      env: [api_endpoint: "https://bittrex.com/api",
            api_version: "v1.1"]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpoison, "~> 0.13"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp description do
    "Elixir library for Bittrex (bittrex.com) exchange API."
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Cosmin Harangus"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://git.cloud.around25.net/startups/trendycoins/bittrex_api"}
    ]
  end
end
