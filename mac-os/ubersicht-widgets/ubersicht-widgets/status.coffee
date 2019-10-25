command: "./statuses/statuses.sh"

refreshFrequency: 10000

render: (output) ->
  """
  <link rel="stylesheet" type="text/css" href="status.css">
  <div class="statuses"></div>
  """

style: """
  right: 18px
  top: 8px
  height: 13px
  """

update: (output, domEl) ->
  $(domEl).find('.statuses').html(output)
