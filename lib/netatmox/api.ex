defmodule Netatmox.Api do
  @moduledoc """
  Get an initial access_token with https://github.com/tvecera/netatmo-auth-cli or from netatmo dev portal after login
  """

  use Tesla
  # TODO: check why netatmo certificate is not accepted
  adapter Tesla.Adapter.Mint, transport_opts: [verify: :verify_none]

  alias Netatmox.Endpoints
  alias Netatmox.Scopes

  plug Tesla.Middleware.DecodeJson
  plug Tesla.Middleware.FormUrlencoded

  @authorization_code_grant_type "authorization_code"
  @refresh_token_grant_type "refresh_token"

  def get_auth_url(client_id) do
    state = random_string(16)

    body = %{
      "client_id" => client_id,
      "state" => state,
      "redirect_uri" => "http://localhost:4000/oauth2/callback",
      "scope" => Scopes.read_station()
    }

    case post(Endpoints.auth(), body) do
      {:ok, %Tesla.Env{:body => body}} when is_map(body) -> {:ok, body, state}
      error -> {:error, error}
    end
  end

  def retrieve_token(client_id, client_secret, code) do
    body = %{
      "grant_type" => @authorization_code_grant_type,
      "client_id" => client_id,
      "client_secret" => client_secret,
      "code" => code,
      "redirect_uri" => "http://localhost:4000/oauth2/callback",
      "scope" => Scopes.read_station()
    }

    case post(Endpoints.token(), body) do
      {:ok, %Tesla.Env{:body => body}} when is_map(body) -> {:ok, body}
      error -> {:error, error}
    end
  end

  def refresh_token(client_id, client_secret, refresh_token) do
    body = %{
      "grant_type" => @refresh_token_grant_type,
      "client_id" => client_id,
      "client_secret" => client_secret,
      "refresh_token" => refresh_token
    }

    case post(Endpoints.token(), body) do
      {:ok, %Tesla.Env{status: 200, body: body}} -> {:ok, body}
      error -> {:error, error}
    end
  end

  def station_data(access_token) do
    case get(Endpoints.station_data(), headers: [{"Authorization", "Bearer #{access_token}"}]) do
      {:ok, %Tesla.Env{status: 200, body: body}} -> {:ok, body}
      error -> {:error, error}
    end
  end


  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end
end
