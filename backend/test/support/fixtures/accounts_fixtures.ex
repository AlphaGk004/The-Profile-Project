defmodule Backend.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Backend.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        cert: "some cert",
        discord: "some discord",
        dob: ~D[2026-02-14],
        document: "some document",
        email: "some email",
        gender: "some gender",
        github: "some github",
        hackerrank: "some hackerrank",
        instagram: "some instagram",
        leetcode: "some leetcode",
        linkedin: "some linkedin",
        marriage_status: "some marriage_status",
        name: "some name",
        password_hash: "some password_hash",
        phone_no: "some phone_no",
        profile_pic: "some profile_pic",
        slack: "some slack",
        twitter: "some twitter"
      })
      |> Backend.Accounts.create_user()

    user
  end
end
