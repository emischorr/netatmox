defmodule Netatmox do
  @moduledoc """
  Documentation for `Netatmox`.
  """

  @doc """
  Refresh both, access and refresh token, with a still valid refresh token.
  Tokens are valid for 3h.
  """
  defdelegate refresh_token(client_id, client_secret, refresh_token), to: Netatmox.Api

  @doc """
  Retrieve weater data from a Netatmo station with an associated access token
  """
  defdelegate station_data(access_token), to: Netatmox.Api
end
