defmodule BackendWeb.UserController do
  use BackendWeb, :controller

  alias Backend.Accounts
  alias Backend.Accounts.User

  action_fallback BackendWeb.FallbackController

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{} = user} <- Accounts.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)

    with {:ok, %User{}} <- Accounts.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end

   def register(conn, %{
  "name" => name,
  "email" => email,
  "password_hash" => password_hash,
  "dob" => dob,
  "marriage_status" => marriage_status,
  "gender" => gender,
  "phone_no" => phone_no,
  "github" => github,
  "linkedin" => linkedin,
  "twitter" => twitter,
  "instagram" => instagram,
  "leetcode" => leetcode,
  "hackerrank" => hackerrank,
  "discord" => discord,
  "slack" => slack,
  "profile_pic" => profile_pic,
  "document" => document,
  "cert" => cert
}) do
  case Accounts.register(name, email, password_hash, dob, marriage_status, gender, phone_no, github, linkedin, twitter, instagram, leetcode, hackerrank, discord, slack, profile_pic, document, cert) do
    {:ok, _} -> json(conn, %{status: "registered"})
    {:error, reason} -> json(conn |> put_status(400), %{error: reason})
  end
 end

 def login(conn, %{"email" => email, "password_hash" => password_hash}) do
  case Accounts.login(email, password_hash) do
    {:ok, user} ->
      json(conn, %{
        status: "success",
        email: user["email"],
        password_hash: user["password_hash"]
      })

    {:error, :invalid_credentials} ->
      json(conn, %{
        status: "error",
        message: "Invalid credentials"
      })
  end
end

def details(conn, _params) do
  data = Accounts.list_all_users_raw()
  json(conn,%{status: "data",data: data})
end

def update_details(conn, params) do
  email = params["email"]

  case Accounts.get_user_by_email(email) do
    nil ->
      json(conn, %{status: "error", message: "User not found"})

    user ->
      case Accounts.update_user(user, params) do
        {:ok, updated_user} ->
          json(conn, %{status: "success", data: updated_user})

        {:error, changeset} ->
          json(conn, %{status: "error", errors: changeset})
      end
  end
end

end
