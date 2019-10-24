command: "./code/status.sh"

refreshFrequency: 10000

render: (output) ->
  """
  <div class="status"></div>
  """

style: """
  font-family: monaco
  font-size: 11px
  color: #bebebe;
  right: 18px
  top: 8px
  height: 13
  """

update: (output, domEl) ->
  output = output.replace /@.*?@/g, (match) -> "<i class='fas fa-" + (match.replace /@/g, '') + "'></i>"
  $(domEl).find('.status').html(output)
