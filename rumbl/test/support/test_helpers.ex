defmodule Rumbl.TestHelpers do

  alias Rumbl.{
    Accounts,
    Accounts.User,
    Multimedia
    }

  def user_fixture(attrs \\ %{}) do
    {:ok, user} = Enum.into(attrs, %{
      name: "Some User",
      username: "user#{System.unique_integer([:positive])}",
      password: attrs[:password] || "supersecret",
      email: attrs[:email] || "someuser@example.com",
    }) |> Accounts.register_user()

    user
  end

  def video_fixture(%User{} = user, attrs \\ %{}) do
    attrs = Enum.into(attrs, %{
      title: "A Title",
      url: "http://example.com",
      description: "a description"
    })

    {:ok, video} = Multimedia.create_video(user, attrs)
    video
  end

end