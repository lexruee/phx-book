defmodule RumblWeb.AuthTest do
  use RumblWeb.ConnCase, async: true
  alias RumblWeb.Auth
  alias Rumbl.Accounts.User

  setup %{conn: conn} do
    conn = conn
           |> bypass_through(RumblWeb.Router, :browser)
           |> get("/")

    {:ok, %{conn: conn}}
  end

  test "authenticate_user halts when no current_user exists", %{conn: conn} do
    conn =  Auth.authenticate_user(conn, [])
    assert conn.halted
  end

  test "authenticate_user continues when current_user exists", %{conn: conn} do
    conn = conn
           |> assign(:current_user, %User{})
           |> Auth.authenticate_user([])

    refute conn.halted
  end

  test "login puts the user in the session", %{conn: conn} do
    login_conn = conn
                 |> Auth.login(%User{id: 123})
                 |> send_resp(:ok, "")

    next_conn = get(login_conn, "/")
    assert 123 = get_session(next_conn, :user_id)
  end

  test "login drops the session", %{conn: conn} do
    login_conn = conn
                 |> put_session(:user_id, 123)
                 |> Auth.logout()
                 |> send_resp(:ok, "")

    next_conn = get(login_conn, "/")
    refute get_session(next_conn, :user_id)
  end
end