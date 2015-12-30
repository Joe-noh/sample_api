defmodule SampleAPI.Router do
  use SampleAPI.Web, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SampleAPI do
    pipe_through :api
  end
end
