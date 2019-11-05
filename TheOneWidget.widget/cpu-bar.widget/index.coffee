command: "top -u -l 1"

refreshFrequency: 2000

style: """
  // Change bar height
  bar-height = 6px

  // Align contents left or right
  widget-align = left

  // Position this where you want
  top: 9.5%
  left 10px

  // Statistics text settings
  color #fff
  font-family Hack Nerd Font
  background rgba(#FFF, .1)
  padding 10px 10px 15px
  border-radius 5px

  .CPUBarContainer
    width: 300px
    text-align: widget-align
    position: relative
    clear: both

  .CPUBarWidget-title
    text-align: widget-align

  .CPUBarStats-container
    margin-bottom 5px
    border-collapse collapse

  td
    font-size: 13px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align
    width: 35%

  td.pctg
    float: right

  .CPUBarWidget-title, p
    font-size 13px
    text-transform uppercase
    font-weight bold

  .CPUBarLabel
    font-size 13px
    text-transform uppercase
    font-weight bold

  .CPUBarBar-container
    width: 100%
    height: bar-height
    border-radius: bar-height
    float: widget-align
    clear: both
    background: rgba(#fff, .5)
    position: absolute
    margin-bottom: 5px

  .CPUBarBar
    height: bar-height
    float: widget-align
    transition: width .2s ease-in-out

  .CPUBarBar:first-child
    if widget-align == left
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .CPUBarBar:last-child
    if widget-align == right
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .CPUBarBar-inactive
    background: rgba(#0bf, .5)

  .CPUBarBar-sys
    background: rgba(#fc0, .5)

  .CPUBarBar-user
    background: rgba(#c00, .5)
    
"""


render: -> """
  <div class="CPUBarContainer">
    <div class="CPUBarWidget-title">CPU:</div>
    <table class="CPUBarStats-container" width="100%">
      <tr>
        <td class="stat"><span class="user"></span></td>
        <td class="stat"><span class="sys"></span></td>
        <td class="stat pctg"><span class="idle"></span></td>
      </tr>
      <tr>
        <td class="CPUBarLabel">user</td>
        <td class="CPUBarLabel">sys</td>
        <td class="CPUBarLabel pctg">idle</td>
      </tr>
    </table>
    <div class="CPUBarBar-container">
      <div class="CPUBarBar CPUBarBar-user"></div>
      <div class="CPUBarBar CPUBarBar-sys"></div>
      <div class="CPUBarBar bar-idle"></div>
    </div>
  </div>
"""

update: (output, domEl) ->
  updateStat = (sel, usage) ->
    percent = usage + "%"
    $(domEl).find(".#{sel}").text usage
    $(domEl).find(".CPUBarBar-#{sel}").css "width", percent

  lines = output.split "\n"

  userRegex = /(\d+\.\d+)%\suser/
  user = userRegex.exec(lines[3])[1]

  systemRegex = /(\d+\.\d+)%\ssys/
  sys = systemRegex.exec(lines[3])[1]

  idleRegex = /(\d+\.\d+)%\sidle/
  idle = idleRegex.exec(lines[3])[1]

  updateStat 'user', user
  updateStat 'sys', sys
  updateStat 'idle', idle
