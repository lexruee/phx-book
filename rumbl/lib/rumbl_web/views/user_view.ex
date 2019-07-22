defmodule RumblWeb.UserView do
  use RumblWeb, :view

  alias Rumbl.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split
    |> hd
  end

  def last_name(%Accounts.User{name: name}) do
    name
    |> String.split
    |> tl
  end
end