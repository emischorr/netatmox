# Netatmox

A simple wrapper around the Netatmo Weather API.
Currently just two functions are supported. One to retrieve the station data and another to update the tokens.

## Tokens
You need an access token with the scope `read_station` to get the data from your weather station. The token is right now only 3h valid and needs to be refreshed with an refresh token. You can either use something like [Netatmo-Auth-Cli](https://github.com/tvecera/netatmo-auth-cli) to do the inital OAuth2 flow to retrieve the tokens or you can generate an access and refresh from the app page in the Netatmo dev portal.

Make sure to save both access and refresh token after every refresh as both will invalidate after 3h and you need the refreh token to do so.

## Usage

Get station data:
```elixir
Netatmox.station_data("18e982cb723c36c7b...")
{:ok,
 %{
   "body" => %{
     "devices" => [
       %{
         "co2_calibrating" => false,
         "dashboard_data" => %{
           "AbsolutePressure" => 985.3,
           "CO2" => 1449,
           "Humidity" => 65,
           "Noise" => 35,
           "Pressure" => 1008.1,
           "Temperature" => 21.3,
           "date_max_temp" => 1702422085,
           "date_min_temp" => 1702429337,
           "max_temp" => 21.4,
           "min_temp" => 20.9,
           "pressure_trend" => "up",
           "temp_trend" => "stable",
         }
         # ...
       }
     ]
   }
 }
}
```

Refresh tokens:
```elixir
Netatmox.refresh_token(client_id, client_secret, refresh_token)
{:ok,
 %{
   "access_token" => "18e982cb723c36c7b...",
   "expire_in" => 10800,
   "expires_in" => 10800,
   "refresh_token" => "18e982cb723c36c7b...",
   "scope" => ["read_station"]
 }}
```

## Installation

The package can be installed by adding `netatmox` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:netatmox, "~> 0.1.0"}
  ]
end
```
