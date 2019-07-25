defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts context.
  """

  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_by_username_and_pass(username, given_pass) do
    case user = get_user_by(username: username) do
      %User{password_hash: password_hash} ->
        case Pbkdf2.verify_pass(given_pass, password_hash) do
          true -> {:ok, user}
          false -> {:error, :unauthorized}
        end
      _ ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end