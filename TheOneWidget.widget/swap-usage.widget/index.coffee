command: "sysctl -n vm.swapusage | awk '{printf \"%s,%s\\n%s,%s\\n%s,%s\", $1,$3,$4,$6,$7,$9}'"

refreshFrequency: 5000

style: """
  top: 770px
  left: 10px
  color: #fff
  font-family: Helvetica Neue


  table
    border-collapse: collapse
    table-layout: fixed

    &:before
      content: 'swap'
      position: absolute
      left: 0
      top: -14px
      font-size: 10px

  td
    font-size: 12px
    font-weight: 100
    width: 130px
    max-width: 130px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .SwapUsageValue
    padding: 4px 6px 4px 6px
    position: relative

  .SwapUsageCol1
    background: rgba(#fff, 0.1)
    border-radius 5px

   .SwapUsageCol2
    background: rgba(#fff, 0.05)
    border-radius 5px
    
   .SwapUsageCol3
    background: rgba(#fff, 0.025)
    border-radius 5px

  p
    padding: 0
    margin: 0
    font-size: 11px
    font-weight: normal
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis

"""


render: ->
  """
  <table>
    <tr>
      <td class='SwapUsageCol1'></td>
      <td class='SwapUsageCol2'></td>
      <td class='SwapUsageCol3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (name, value) ->
    "<div class='SwapUsageValue'>" +
      "#{value}<p>#{name}</p>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".SwapUsageCol#{i+1}").html renderProcess(args...)
