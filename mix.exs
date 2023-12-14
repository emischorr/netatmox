defmodule Netatmox.MixProject do
  use Mix.Project

  def project do
    [
      app: :netatmox,
      version: "0.1.0",
      name: "netatmox",
      description: "A wrapper for the Netatmo Weather Station API",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: "https://github.com/emischorr/netatmox"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:tesla, "~> 1.4"},
      {:jason, ">= 1.0.0"},
      {:mint, "~> 1.0"},
      {:castore, "~> 1.0"}
    ]
  end

  defp package() do
    [
      name: "netatmox",
      # These are the default files included in the package
      files: ~w(lib priv .formatter.exs mix.exs README* readme* LICENSE*
                license* CHANGELOG* changelog* src),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/emischorr/netatmox"}
    ]
  end
end
