defmodule ToyRobot do
  @table_top_x 4
  @table_top_y 4


  @doc """
  Places the robot in the default position

  Examples:
      iex> ToyRobot.place
      %ToyRobot.Position{facing: :north, x: 0, y: 0}
  """
  def place do
    %ToyRobot.Position{}
  end

  @doc """
  Places the robot in the provided position,
  but prevents it to be placed outside of the table and facing invalid direction.

  Examples:

      iex> ToyRobot.place(1, 2, :south)
      %ToyRobot.Position{facing: :south, x: 1, y: 2}

      iex> ToyRobot.place(-1, -1, :north)
      {:failure, "Invalid position"}

      iex> ToyRobot.place(0, 0, :north_east)
      {:failure, "Invalid facing direction"}
  """
  def place(x, y, _facing) when x < 0 or y < 0 or x > @table_top_y or y > @table_top_y
    do
    {:failure, "Invalid position"}
  end

  def place(_x, _y, facing) when facing not in [:north, :east, :south, :west]
    do
    {:failure, "Invalid facing direction"}
  end


  def place(x, y, facing) do
    %ToyRobot.Position{x: x, y: y, facing: facing}
  end



  def report(robot) do
    %ToyRobot.Position{x: x, y: y, facing: facing} = robot
    {x, y, facing}
  end
  def right1(%ToyRobot.Position{facing: facing} = robot) do
    directions_to_the_right = %{north: :east, east: :south, south: :west, west: :north}

    %ToyRobot.Position{robot | facing: directions_to_the_right[facing]}
  end
  def left1(%ToyRobot.Position{facing: facing} = robot) do
    directions_to_the_left = %{north: :west, east: :north, south: :east, west: :south}

    %ToyRobot.Position{robot | facing: directions_to_the_left[facing]}
  end

  @directions_to_the_right %{north: :east, east: :south, south: :west, west: :north}
  def right(%ToyRobot.Position{facing: facing} = robot) do
    %ToyRobot.Position{robot | facing: @directions_to_the_right[facing]}
  end

  @directions_to_the_left Enum.map(@directions_to_the_right, fn {from, to} -> {to, from} end)
  def left(%ToyRobot.Position{facing: facing} = robot) do
    %ToyRobot.Position{robot | facing: @directions_to_the_left[facing]}
  end

  def move(%ToyRobot.Position{x: x, y: y, facing: f} = robot) do
    case f do
      :north -> %ToyRobot.Position{robot | y: Enum.min([@table_top_y, y + 1])}
      :east -> %ToyRobot.Position{robot | x: Enum.min([@table_top_x, x + 1])}
      :south when y > 0 -> %ToyRobot.Position{robot | y: y - 1}
      :west when x > 0 -> %ToyRobot.Position{robot | x: x - 1}
      _ -> robot
    end
  end


end
