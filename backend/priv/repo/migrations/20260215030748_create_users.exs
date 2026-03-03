defmodule Backend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :password_hash, :string
      add :dob, :date
      add :marriage_status, :string
      add :gender, :string
      add :phone_no, :string
      add :github, :string
      add :linkedin, :string
      add :twitter, :string
      add :instagram, :string
      add :leetcode, :string
      add :hackerrank, :string
      add :discord, :string
      add :slack, :string
      add :profile_pic, :binary
      add :document, :binary
      add :cert, :binary

      timestamps(type: :utc_datetime)
    end
  end
end
