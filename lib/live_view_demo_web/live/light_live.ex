defmodule LiveViewDemoWeb.LightLive do
  use LiveViewDemoWeb, :live_view

  def mount(_params, _session, socket) do
    LiveViewDemo.PubSub |> Phoenix.PubSub.subscribe("light")
    {:ok, assign(socket, :brightness, 10)}
  end

  def render(assigns) do
    ~L"""
    <h1>Lamparita</h1>
    <div class="meter">
      <span style="width: <%= @brightness %>%">
        <%= @brightness %>%
      </span>
    </div>

    <button phx-click="off">
      Off
      </button>

      <button phx-click="down">
      Down
      </button>

      <button phx-click="up">
      Up
      </button>

      <button phx-click="on">
      On
      </button>
    """
  end

  def handle_event("on", _, socket) do
    socket = assign(socket, :brightness, 100)

    LiveViewDemo.PubSub
    |> Phoenix.PubSub.broadcast("light", {:change_brightness, 100})

    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    socket = assign(socket, :brightness, 0)
    {:noreply, socket}
  end

  def handle_event("down", _, socket) do
    socket = update(socket, :brightness, &max(&1 - 10, 0))
    {:noreply, socket}
  end

  def handle_event("up", _, socket) do
    socket = update(socket, :brightness, &min(&1 + 10, 100))
    {:noreply, socket}
  end

  def handle_info({:change_brightness, brightness_value}, socket) do
    socket = assign(socket, :brightness, brightness_value)
    {:noreply, socket}
  end
end
