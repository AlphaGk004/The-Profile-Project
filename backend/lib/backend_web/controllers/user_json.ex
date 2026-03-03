defmodule BackendWeb.UserJSON do
  alias Backend.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      password_hash: user.password_hash,
      dob: user.dob,
      marriage_status: user.marriage_status,
      gender: user.gender,
      phone_no: user.phone_no,
      github: user.github,
      linkedin: user.linkedin,
      twitter: user.twitter,
      instagram: user.instagram,
      leetcode: user.leetcode,
      hackerrank: user.hackerrank,
      discord: user.discord,
      slack: user.slack,
      profile_pic: user.profile_pic,
      document: user.document,
      cert: user.cert
    }
  end
end
