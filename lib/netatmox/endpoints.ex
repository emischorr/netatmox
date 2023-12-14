defmodule Netatmox.Endpoints do
  @host "https://api.netatmo.com"
  @auth_endpoint "/oauth2/authorize"
  @token_endpoint "/oauth2/token"
  @public_data_endpint "/api/getpublicdata" # retrieve shared weather data in defined area
  @station_data_endpoint "/api/getstationsdata" # data saved in the cloud (updated every 10 min)
  @home_status_endpoint "/api/homestatus" # data near realtime from the device (over the cloud)
  @measure_endpoint "/api/getmeasure" # retrieve data from a device/module

  def host, do: @host
  def auth, do: "#{host()}#{@auth_endpoint}"
  def token, do: "#{host()}#{@token_endpoint}"
  def station_data, do: "#{host()}#{@station_data_endpoint}"
  def home_status, do: "#{host()}#{@home_status_endpoint}"
  def measure, do: "#{host()}#{@measure_endpoint}"
end
