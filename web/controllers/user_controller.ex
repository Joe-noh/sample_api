defmodule SampleAPI.UserController do
  use SampleAPI.Web, :controller

  alias SampleAPI.User

  plug :scrub_params, "user" when action in [:create, :update]

  @users [
    %User{id: 1, name: "Alice",   age: 20},
    %User{id: 2, name: "Bob",     age: 30},
    %User{id: 3, name: "Charlie", age: 40}
  ]

  def index(conn, _params) do
    users = @users
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params = %{"name" => name, "age" => age}}) do
    user = %User{id: 4, name: name, age: age}

    conn
    |> put_status(:created)
    |> put_resp_header("location", user_path(conn, :show, user))
    |> render("show.json", user: user)
  end

  def create(conn, %{"user" => invalid_params}) do
    changeset = User.changeset(%User{}, invalid_params)

    conn
    |> put_status(:unprocessable_entity)
    |> render(SampleAPI.ChangesetView, "error.json", changeset: changeset)
  end

  def show(conn, %{"id" => id}) when id in ~w[1 2 3] do
    user = Enum.at(@users, String.to_integer(id) - 1)
    render(conn, "show.json", user: user)
  end

  def show(conn, %{"id" => _id}) do
    conn
    |> put_status(:not_found)
    |> render(SampleAPI.ErrorView, "404.json")
  end

  def update(conn, %{"id" => id, "user" => user_params = %{"name" => _, "age" => _}}) do
    user = Enum.at(@users, String.to_integer(id) - 1)

    changeset = User.changeset(user, user_params)

    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => invalid_params}) do
    changeset = User.changeset(%User{}, invalid_params)

    conn
    |> put_status(:unprocessable_entity)
    |> render(SampleAPI.ChangesetView, "error.json", changeset: changeset)
  end

  def delete(conn, %{"id" => id}) do
    send_resp(conn, :no_content, "")
  end
end
