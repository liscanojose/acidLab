class WebNotificationsChannel < ApplicationCable::Channel
  include CitiesHelper
  def subscribed
    stream_from "web_notifications_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def info
    ActionCable.server.broadcast 'web_notifications_channel', message: fetch_cities[:cities]
  end
end