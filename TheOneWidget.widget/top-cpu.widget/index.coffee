command: "ps axro \"%cpu,ucomm,pid\" | awk 'FNR>1' | tail +1 | head -n 3 | sed -e 's/^[ ]*\\([0-9][0-9]*\\.[0-9][0-9]*\\)\\ /\\1\\%\\,/g' -e 's/\\ \\ *\\([0-9][0-9]*$\\)/\\,\\1/g'"

refreshFrequency: 2000

style: """
  color: #fff
  font-family: Hack Nerd Font
  left: 10px
  top: 53.5%
  
  table
    border-collapse: collapse
    table-layout: fixed

    &:after
      content: 'Top CPU:'
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

  .TopCPUWrapper
    padding: 4px 6px 4px 6px
    position: relative

  .TopCPUCol1
    background: rgba(#fff, 0.1)
    border-radius 5px

  .TopCPUCol2
    background: rgba(#fff, 0.05)
    border-radius 5px
 
  .TopCPUCol3
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

  .TopCPUCPid
    position: absolute
    top: 2px
    right: 2px
    font-size: 10px
    font-weight: normal

"""


render: -> """
  <table>
    <tr>
      <td class='TopCPUCol1'></td>
      <td class='TopCPUCol2'></td>
      <td class='TopCPUCol3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='TopCPUWrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='TopCPUCPid'>#{id}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".TopCPUCol#{i+1}").html renderProcess(args...)

