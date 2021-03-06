command: "sysctl -n vm.loadavg | awk '{printf \"%s,%s,%s\",$2,$3,$4}'"

refreshFrequency: 5000

style: """
    color: #fff
    font-family: Hack Nerd Font
    left: 0.5%
    top: 64.5%

    table
      border-collapse: collapse
      table-layout: fixed

      &:after
        content: 'Load AVG:'
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

    .LoadAVGValue
      padding: 4px 6px 4px 6px
      position: relative

    .LoadAVGCol1
      background: rgba(#fff, 0.1)
      border-radius 5px

    .LoadAVGCol2
      background: rgba(#fff, 0.05)
      border-radius 5px
 
    .LoadAVGCol3
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
      text-shadow: none
"""

render: -> """
  <table>
    <tr>
      <td class='LoadAVGCol1'></td>
      <td class='LoadAVGCol2'></td>
      <td class='LoadAVGCol3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  values = output.split(',')
  table     = $(domEl).find('table')

  renderValue = (load_avg, index, label) ->
    "<div class='LoadAVGValue'>" +
      "#{load_avg}" +
      "<p class=label> #{label}</p>" +
    "</div>"

  for value, i in values
    if i == 0
      label = '1 Minute'
    else if i == 1
      label = '5 Minute'
    else if i == 2
      label = '15 Minute'

    table.find(".LoadAVGCol#{i+1}").html renderValue(value,i, label)
