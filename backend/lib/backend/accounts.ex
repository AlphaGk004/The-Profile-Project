defmodule Backend.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Backend.Repo

  alias Backend.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{data: %User{}}

  """
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end


 def register(name, email, password_hash, dob, marriage_status, gender, phone_no, github, linkedin, twitter, instagram, leetcode, hackerrank, discord, slack, profile_pic, document, cert) do
  query = """
  INSERT INTO users (
    name, email, password_hash, dob, marriage_status, gender, phone_no,
    github, linkedin, twitter, instagram, leetcode, hackerrank,
    discord, slack, profile_pic, document, cert,
    inserted_at, updated_at
  )
  VALUES (
    $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,
    $11,$12,$13,$14,$15,$16,$17,$18,
    NOW(), NOW()
  )
  """

  case Ecto.Adapters.SQL.query(Repo, query, [name, email, password_hash, dob, marriage_status, gender, phone_no, github, linkedin, twitter, instagram, leetcode, hackerrank, discord, slack, profile_pic, document, cert]) do
    {:ok, _} -> {:ok, "User registered"}
    {:error, reason} -> {:error, reason}
  end
end

def login(email, password_hash) do
  query = """
  SELECT * FROM users
  WHERE email = $1 AND password_hash = $2
  """

  case Repo.query(query, [email, password_hash]) do
    {:ok, %Postgrex.Result{rows: [row | _], columns: columns}} ->
      user = Enum.zip(columns, row) |> Enum.into(%{})
      {:ok, user}

    _ ->
      {:error, :invalid_credentials}
  end
end

def list_all_users_raw do
  {:ok, result} =
    Repo.query("SELECT * FROM users ORDER BY id")

  Enum.map(result.rows, fn row ->
    Enum.zip(result.columns, row)
    |> Enum.into(%{})
  end)
end

# def update_details(name, email, password_hash, dob, marriage_status, gender, phone_no, github, linkedin, twitter, instagram, leetcode, hackerrank, discord, slack, profile_pic, document, cert) do

# end
def get_user_by_email(email) do
  Repo.get_by(User, email: email)
end

end
