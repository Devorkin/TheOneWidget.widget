command: "ps axo \"rss,pid,ucomm\" | sort -nr | tail +1 | head -n3 | awk '{printf \"%8.0f MB,%s,%s\\n\", $1/1024, $3, $2}'"

refreshFrequency: 5000

style: """
  color: #fff
  font-family: Hack Nerd Font
  left: 10px
  top: 59%
  
  table
    border-collapse: collapse
    table-layout: fixed

    &:before
      content: 'Top RAM:'
      position: absolute
      left: 0
      top: -14px
      font-size: 13px

  td
    font-size: 16px
    font-weight: 100
    width: 130px
    max-width: 130px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .TopMemWrapper
    padding: 4px 6px 4px 6px
    position: relative

  .TopMemCol1
    background: rgba(#fff, 0.1)
    border-radius 5px

  .TopMemCol2
    background: rgba(#fff, 0.05)
    border-radius 5px
 
  .TopMemCol3
    background: rgba(#fff, 0.025)
    border-radius 5px

  p
    padding: 0
    margin: 0
    font-size: 12px
    font-weight: normal
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis

  .TopMemPid
    position: absolute
    top: 2px
    right: 2px
    font-size: 10px
    font-weight: normal

"""


render: ->
  """
  <table>
    <tr>
      <td class='TopMemCol1'></td>
      <td class='TopMemCol2'></td>
      <td class='TopMemCol3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='TopMemWrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='TopMemPid'>#{id}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".TopMemCol#{i+1}").html renderProcess(args...)

