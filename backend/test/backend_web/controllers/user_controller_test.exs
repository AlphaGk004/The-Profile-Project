defmodule BackendWeb.UserControllerTest do
  use BackendWeb.ConnCase

  import Backend.AccountsFixtures
  alias Backend.Accounts.User

  @create_attrs %{
    name: "some name",
    github: "some github",
    cert: "some cert",
    email: "some email",
    password_hash: "some password_hash",
    dob: ~D[2026-02-14],
    marriage_status: "some marriage_status",
    gender: "some gender",
    phone_no: "some phone_no",
    linkedin: "some linkedin",
    twitter: "some twitter",
    instagram: "some instagram",
    leetcode: "some leetcode",
    hackerrank: "some hackerrank",
    discord: "some discord",
    slack: "some slack",
    profile_pic: "some profile_pic",
    document: "some document"
  }
  @update_attrs %{
    name: "some updated name",
    github: "some updated github",
    cert: "some updated cert",
    email: "some updated email",
    password_hash: "some updated password_hash",
    dob: ~D[2026-02-15],
    marriage_status: "some updated marriage_status",
    gender: "some updated gender",
    phone_no: "some updated phone_no",
    linkedin: "some updated linkedin",
    twitter: "some updated twitter",
    instagram: "some updated instagram",
    leetcode: "some updated leetcode",
    hackerrank: "some updated hackerrank",
    discord: "some updated discord",
    slack: "some updated slack",
    profile_pic: "some updated profile_pic",
    document: "some updated document"
  }
  @invalid_attrs %{name: nil, github: nil, cert: nil, email: nil, password_hash: nil, dob: nil, marriage_status: nil, gender: nil, phone_no: nil, linkedin: nil, twitter: nil, instagram: nil, leetcode: nil, hackerrank: nil, discord: nil, slack: nil, profile_pic: nil, document: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, ~p"/api/users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "cert" => "some cert",
               "discord" => "some discord",
               "dob" => "2026-02-14",
               "document" => "some document",
               "email" => "some email",
               "gender" => "some gender",
               "github" => "some github",
               "hackerrank" => "some hackerrank",
               "instagram" => "some instagram",
               "leetcode" => "some leetcode",
               "linkedin" => "some linkedin",
               "marriage_status" => "some marriage_status",
               "name" => "some name",
               "password_hash" => "some password_hash",
               "phone_no" => "some phone_no",
               "profile_pic" => "some profile_pic",
               "slack" => "some slack",
               "twitter" => "some twitter"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "cert" => "some updated cert",
               "discord" => "some updated discord",
               "dob" => "2026-02-15",
               "document" => "some updated document",
               "email" => "some updated email",
               "gender" => "some updated gender",
               "github" => "some updated github",
               "hackerrank" => "some updated hackerrank",
               "instagram" => "some updated instagram",
               "leetcode" => "some updated leetcode",
               "linkedin" => "some updated linkedin",
               "marriage_status" => "some updated marriage_status",
               "name" => "some updated name",
               "password_hash" => "some updated password_hash",
               "phone_no" => "some updated phone_no",
               "profile_pic" => "some updated profile_pic",
               "slack" => "some updated slack",
               "twitter" => "some updated twitter"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/users/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()

    %{user: user}
  end
end
