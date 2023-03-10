defmodule ToyRobotTest do
  use ExUnit.Case
  doctest ToyRobot







  test "provides the report of the robot's position" do
    robot = ToyRobot.place(2, 3, :west)
    assert ToyRobot.report(robot) == {2, 3, :west}
  end

  test "rotates the robot to the right" do
    position = ToyRobot.place(0, 0, :north)
               |> ToyRobot.right
               |> ToyRobot.report

    assert position == {0, 0, :east}

    position = ToyRobot.place(0, 0, :north)
               |> ToyRobot.right
               |> ToyRobot.right
               |> ToyRobot.report

    assert position == {0, 0, :south}

  end

  test "rotates the robot to the left" do
    position = ToyRobot.place(0, 0, :north)
               |> ToyRobot.left
               |> ToyRobot.report

    assert position == {0, 0, :west}
  end

  test "rotating the robot 3 times to the right is the same as rotating it to the left" do
    right_position = ToyRobot.place(0, 0, :north)
                     |> ToyRobot.right
                     |> ToyRobot.right
                     |> ToyRobot.right
                     |> ToyRobot.report

    left_position =  ToyRobot.place(0, 0, :north)
                     |> ToyRobot.left
                     |> ToyRobot.report

    assert right_position == left_position
  end

  test "moving robot up if it is facing to the north" do
    position = ToyRobot.place(0, 0, :north)
               |> ToyRobot.move
               |> ToyRobot.report

    assert position == {0, 1, :north}
  end

  test "moving robot right if it is facing to the east" do
    position = ToyRobot.place(0, 0, :east)
               |> ToyRobot.move
               |> ToyRobot.report

    assert position == {1, 0, :east}
  end

  test "moving robot down if it is facing to the south" do
    position = ToyRobot.place(4, 4, :south)
               |> ToyRobot.move
               |> ToyRobot.report

    assert position == {4, 3, :south}
  end

  test "moving robot left if it is facing to the west" do
    position = ToyRobot.place(4, 4, :west)
               |> ToyRobot.move
               |> ToyRobot.report

    assert position == {3, 4, :west}
  end

  test "prevent the robot to fall" do
    position = ToyRobot.place(4, 4, :north)
               |> ToyRobot.move
               |> ToyRobot.report

    assert position == {4, 4, :north}
  end



end
