defmodule PublicSuffex.Mixfile do
  use Mix.Project

  def project do
    [
      app: :public_suffex,
      version: "0.0.1",
      elixir: "~> 1.2",
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      description: description,
      package: package,
      deps: deps,
   ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp description do
    """
    A module for determining the TLD given a valid URL.

    A special thank you to @elbow-jason for all his mentorship and code expertise. 

    """
  end

  defp package do
    [
      name: :public_suffex,
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Jason Goldberger(elbow-jason)", "Ryan Hurst"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/captainhurst/public_suffex"}
    ]
 end
  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
