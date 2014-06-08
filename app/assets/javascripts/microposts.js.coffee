updateCountdown = ->
  maxChars = 140
  amtLeft = maxChars - $("#micropost_content").val().length
  if amtLeft == 1
    charactersLeft = ' character left.'
  else if amtLeft < 0
    charactersLeft = ' characters too many.'
  else
    charactersLeft = ' characters left.'
  amtLeft = Math.abs(amtLeft)
  jQuery(".countdown").text amtLeft + charactersLeft

jQuery ->
  if $("#micropost_content").val() != undefined
    updateCountdown()
    $("#micropost_content").change updateCountdown
    $("#micropost_content").keyup updateCountdown