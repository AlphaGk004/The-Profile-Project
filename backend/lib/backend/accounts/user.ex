defmodule Backend.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :password_hash, :string
    field :dob, :date
    field :marriage_status, :string
    field :gender, :string
    field :phone_no, :string
    field :github, :string
    field :linkedin, :string
    field :twitter, :string
    field :instagram, :string
    field :leetcode, :string
    field :hackerrank, :string
    field :discord, :string
    field :slack, :string
    field :profile_pic, :binary
    field :document, :binary
    field :cert, :binary

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password_hash, :dob, :marriage_status, :gender, :phone_no, :github, :linkedin, :twitter, :instagram, :leetcode, :hackerrank, :discord, :slack, :profile_pic, :document, :cert])
    # |> validate_required([:name, :email, :password_hash, :dob, :marriage_status, :gender, :phone_no, :github, :linkedin, :twitter, :instagram, :leetcode, :hackerrank, :discord, :slack, :profile_pic, :document, :cert])
  end
end
