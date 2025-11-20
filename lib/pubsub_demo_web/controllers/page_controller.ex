defmodule PubsubDemoWeb.PageController do
  use PubsubDemoWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
