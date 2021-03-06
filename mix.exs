defmodule PhoenixPoker.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_poker,
     version: "0.0.1",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases,
     deps: deps]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {PhoenixPoker, []},
      applications: [
        :phoenix,
        :phoenix_html,
        :cowboy,
        :logger,
        :phoenix_ecto,
        :postgrex,
        :oauth,
        :ueberauth_facebook,
        :ueberauth_google,
        :ueberauth_github,
        :ueberauth_identity,
        :ueberauth_slack,
        :ueberauth_twitter,
        :timex,
        :bamboo
      ]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix, "~> 1.2"},
     {:phoenix_ecto, "~> 3.0.0-rc"},
     {:postgrex, ">= 0.11.1", override: true},
     {:phoenix_html, "~> 2.6"},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:cowboy, "~> 1.0"},
     {:ueberauth, "~> 0.2"},
     {:oauth, github: "tim/erlang-oauth"},
     {:ueberauth_facebook, "~> 0.4"},
     {:ueberauth_google, "~> 0.2"},
     {:ueberauth_github, "~> 0.2"},
     {:ueberauth_identity, "~> 0.2"},
     {:ueberauth_slack, "~> 0.2"},
     {:ueberauth_twitter, "~> 0.2"},
     {:timex, "~> 3.0"},
     {:bamboo, "~> 0.7"},
     {:bamboo_smtp, "~> 1.2.1"}

     #{:dogma, ">= 0.0.0", only: [:dev, :test]}
   ]
  end

  # Aliases are shortcut or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
