$(document).ready ->
  $('#task_field').focus ->
    $('body').addClass 'focused'
    $('#task_field').data('placeholder', $('#task_field').attr('placeholder'))
    $('#task_field').attr('placeholder', '')
  $('#task_field').blur ->
    $('body').removeClass('focused')
    $('#task_field').attr('placeholder', $('#task_field').data('placeholder'))
  $('form').submit ->
    return unless $('body').hasClass('focused')
    console.log("starting task: #{$('#task_field').val()}")
    $('body').removeClass('start focused').addClass('wip')
    $('#task_field').attr("disabled", "disabled").blur()

  #Mousetrap.bind 's', ->
    #if $('body').hasClass('start')
      #$('#task_field').focus()

  $('body').focus()
