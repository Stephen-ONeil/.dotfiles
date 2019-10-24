command: "./code/status.sh"

refreshFrequency: 10000

render: (output) ->
  """
  <div class="status"></div>
  """

style: """
  right: 18px
  top: 8px
  height: 13

  font-family: menlo
  font-size: 14px
  color: #bebebe;
  """

update: (output, domEl) ->
  $(domEl).find('.status').html(output)
