defmodule Backend.AccountsTest do
  use Backend.DataCase

  alias Backend.Accounts

  describe "users" do
    alias Backend.Accounts.User

    import Backend.AccountsFixtures

    @invalid_attrs %{name: nil, github: nil, cert: nil, email: nil, password_hash: nil, dob: nil, marriage_status: nil, gender: nil, phone_no: nil, linkedin: nil, twitter: nil, instagram: nil, leetcode: nil, hackerrank: nil, discord: nil, slack: nil, profile_pic: nil, document: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", github: "some github", cert: "some cert", email: "some email", password_hash: "some password_hash", dob: ~D[2026-02-14], marriage_status: "some marriage_status", gender: "some gender", phone_no: "some phone_no", linkedin: "some linkedin", twitter: "some twitter", instagram: "some instagram", leetcode: "some leetcode", hackerrank: "some hackerrank", discord: "some discord", slack: "some slack", profile_pic: "some profile_pic", document: "some document"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.github == "some github"
      assert user.cert == "some cert"
      assert user.email == "some email"
      assert user.password_hash == "some password_hash"
      assert user.dob == ~D[2026-02-14]
      assert user.marriage_status == "some marriage_status"
      assert user.gender == "some gender"
      assert user.phone_no == "some phone_no"
      assert user.linkedin == "some linkedin"
      assert user.twitter == "some twitter"
      assert user.instagram == "some instagram"
      assert user.leetcode == "some leetcode"
      assert user.hackerrank == "some hackerrank"
      assert user.discord == "some discord"
      assert user.slack == "some slack"
      assert user.profile_pic == "some profile_pic"
      assert user.document == "some document"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", github: "some updated github", cert: "some updated cert", email: "some updated email", password_hash: "some updated password_hash", dob: ~D[2026-02-15], marriage_status: "some updated marriage_status", gender: "some updated gender", phone_no: "some updated phone_no", linkedin: "some updated linkedin", twitter: "some updated twitter", instagram: "some updated instagram", leetcode: "some updated leetcode", hackerrank: "some updated hackerrank", discord: "some updated discord", slack: "some updated slack", profile_pic: "some updated profile_pic", document: "some updated document"}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.github == "some updated github"
      assert user.cert == "some updated cert"
      assert user.email == "some updated email"
      assert user.password_hash == "some updated password_hash"
      assert user.dob == ~D[2026-02-15]
      assert user.marriage_status == "some updated marriage_status"
      assert user.gender == "some updated gender"
      assert user.phone_no == "some updated phone_no"
      assert user.linkedin == "some updated linkedin"
      assert user.twitter == "some updated twitter"
      assert user.instagram == "some updated instagram"
      assert user.leetcode == "some updated leetcode"
      assert user.hackerrank == "some updated hackerrank"
      assert user.discord == "some updated discord"
      assert user.slack == "some updated slack"
      assert user.profile_pic == "some updated profile_pic"
      assert user.document == "some updated document"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
