updateCountdown = ->
  maxChars = 140
  amtLeft = maxChars - $("#micropost_content").val().length
  color = 1
  if amtLeft == 1
    charactersLeft = ' character left.'
  else if amtLeft < 0
    color = "red"
    charactersLeft = ' characters too many.'
  else
    charactersLeft = ' characters left.'
  if color != "red"
    red = Math.round((153-255)/maxChars *amtLeft + 255)
    green = Math.round(153/maxChars*amtLeft)
    blue = Math.round(153/maxChars*amtLeft)
    color = (red<<16) + (green<<8) + blue
    color = '#' + color.toString(16)
  amtLeft = Math.abs(amtLeft)
  charactersLeft = amtLeft + charactersLeft
  $(".countdown").text charactersLeft
  document.getElementById('eff this').style.color = color


jQuery ->
  if $("#micropost_content").val() != undefined
    updateCountdown()
    $("#micropost_content").change updateCountdown
    $("#micropost_content").keyup updateCountdown