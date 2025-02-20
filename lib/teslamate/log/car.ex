defmodule TeslaMate.Log.Car do
  use Ecto.Schema
  import Ecto.Changeset

  alias TeslaMate.Log.{ChargingProcess, Position, Drive}
  alias TeslaMate.Settings.CarSettings

  schema "cars" do
    field :name, :string
    field :efficiency, :float
    field :eid, :integer
    field :model, :string
    field :trim_badging, :string
    field :vid, :integer

    # TODO: with v2.0 mark as non nullable
    field :vin, :string

    belongs_to :settings, CarSettings

    has_many :charging_processes, ChargingProcess
    has_many :positions, Position
    has_many :drives, Drive

    timestamps()
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:eid, :vid, :name, :model, :efficiency, :trim_badging, :vin])
    |> validate_required([:eid, :vid, :vin])
    |> unique_constraint(:settings_id)
    |> unique_constraint(:eid)
    |> unique_constraint(:vin)
    |> unique_constraint(:vid)
  end
end
