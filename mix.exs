defmodule ZssServiceExample.Mixfile do
  use Mix.Project

  def project do
    [app: :zss_service_example,
     version: "0.1.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :zss_service]]
  end

  defp deps do
    [
      {:zss_service, git: "https://github.com/nickve28/zss_service_suite_service_ex.git"},
      {:zss_client, git: "https://github.com/nickve28/zss_service_suite_client_ex.git"},
      {:wobserver, "~> 0.1"}
    ]
  end
end
