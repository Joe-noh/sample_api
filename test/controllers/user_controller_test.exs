defmodule SampleAPI.UserControllerTest do
  use SampleAPI.ConnCase

  @valid_attrs %{name: "Django", age: 50}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    user = conn
      |> get(user_path(conn, :index))
      |> json_response(200)
      |> Dict.get("data")

    assert user |> is_list
  end

  test "shows chosen resource", %{conn: conn} do
    user = conn
      |> get(user_path(conn, :show, 1))
      |> json_response(200)
      |> Dict.get("data")

    assert user["id"]   == 1
    assert user["name"] == "Alice"
    assert user["age"]  == 20
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    error = conn
      |> get(user_path(conn, :show, -1))
      |> json_response(404)
      |> Dict.get("errors")

    assert error["detail"] == "Page not found"
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    conn = put conn, user_path(conn, :update, 1), user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    conn = put conn, user_path(conn, :update, 1), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    conn = delete conn, user_path(conn, :delete, 1)
    assert response(conn, 204)
  end
end
