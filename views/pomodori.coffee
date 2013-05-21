$(document).ready ->
  $('#task_field').focus ->
    $('body').addClass 'focused'
    $('#task_field').data('placeholder', $('#task_field').attr('placeholder'))
    $('#task_field').attr('placeholder', '')
  $('#task_field').blur ->
    $('body').removeClass('focused')
    $('#task_field').attr('placeholder', $('#task_field').data('placeholder'))
  $('#enable_notifications_link').click ->
    if window.webkitNotifications
      if window.webkitNotifications.checkPermission() is 0
        window.webkitNotifications.createNotification('icon.png', 'Notification Title', 'Notification content...')
      else
        window.webkitNotifications.requestPermission()
  $('form').submit ->
    return unless $('body').hasClass('focused')
    if window.webkitNotifications
      if window.webkitNotifications.checkPermission() is 0
        window.webkitNotifications.createNotification('', 'Pomodoro Started', $('#task_field').val()).show()
    console.log("starting task: #{$('#task_field').val()}")
    $('body').removeClass('start focused').addClass('wip')
    $('#task_field').attr("disabled", "disabled").blur()
    window.timer_end = moment().add('minutes', 20).add('seconds', 1)
    window.timer_id = setInterval(->
      current_time = moment()
      minutes_left = timer_end.diff(current_time, "minutes")
      seconds_left = timer_end.diff(current_time, "seconds") - minutes_left*60
      minutes_left_as_string = minutes_left.toString()
      seconds_left_as_string = seconds_left.toString()
      if current_time >= window.timer_end
        clearInterval(window.timer_id)
        console.log("ring ring")
      if minutes_left < 10
        minutes_left_as_string = "0" + minutes_left_as_string
      if minutes_left is 0
        minutes_left_as_string = "00"

      if seconds_left < 10
        seconds_left_as_string = "0" + seconds_left_as_string
      if seconds_left is 0
        seconds_left_as_string = "00"
      $('.timer').html("#{minutes_left_as_string}:#{seconds_left_as_string}")
     , 250)

  Mousetrap.bind '/', ->
    if $('body').hasClass('start')
      $('#task_field').focus()

  $('body').focus()
