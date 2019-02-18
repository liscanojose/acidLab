App.notifications = App.cable.subscriptions.create "WebNotificationsChannel", 

  connected: -> 
  

  disconnected: ->

  received: (data) ->
    content = ""
    for city in data['message']
      do ->
        content +=  "<tr>
                      <td>#{city.country}</td>
                      <td>#{city.time}</td>
                      <td>#{city.temperature}</td>
                    </tr>"
    $('#messages tbody').html(content)

  info: (message) ->
    @perform 'info', message:message
$(document).ready ->
  time = new Date();
  hour = time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })
  $('#hour').html(hour)
  setInterval () ->
    time = new Date();
    hour = time.toLocaleString('en-US', { hour: 'numeric', minute: 'numeric', hour12: true })
    $('#hour').html(hour)
  , 60000
$(document).ready ->
    App.notifications.info()
    setInterval () ->
        App.notifications.info()
    , 10000