defmodule Rumbl.Accounts do
  @moduledoc """
  The Accouncts context.
  """

  alias Rumbl.Accounts.User

  def list_users do
    [
      %User{id: 1, name: "Jose Valim", username: "josevalim"},
      %User{id: 2, name: "Bruce Tate", username: "redrapids"},
      %User{id: 3, name: "Chris McCord", username: "chrismccord"},
    ]
  end

  def get_user(id), do: list_users() |> Enum.find(&(&1.id == id))

  def get_user_by(params) do
    list_users() |> Enum.find(fn map ->
      Enum.all?(params, fn {key, val} ->
        Map.get(map, key) == val
      end)
    end)
  end
end