# You may exclude certain drives (separate with a pipe)
# Example: exclude = 'MyBook' or exclude = 'MyBook|WD Passport'
exclude   = 'NONE'

# Use base 10 numbers, i.e. 1GB = 1000MB. Leave this true to show disk sizes as
# OS X would (since Snow Leopard)
base10       = true

# appearance
filledStyle  = false # set to true for the second style variant. bgColor will become the text color

width        = '367px'
barHeight    = '36px'
labelColor   = '#fff'
usedColor    = '#d7051d'
freeColor    = '#525252'
bgColor      = '#fff'
borderRadius = '3px'
bgOpacity    = 0.9

# You may optionally limit the number of disk to show
maxDisks: 1

command: "df -#{if base10 then 'H' else 'h'} | grep '/dev/' | while read -r line; do fs=$(echo $line | awk '{print $1}'); name=$(diskutil info $fs | grep 'Volume Name' | awk '{print substr($0, index($0,$3))}'); echo $(echo $line | awk '{print $2, $3, $4, $5}') $(echo $name | awk '{print substr($0, index($0,$1))}'); done | grep -vE '#{exclude}'"

refreshFrequency: 20000

style: """
  // Change bar height
  bar-height = 6px

  // Align contents left or right
  widget-align = left

  // Position this where you want
  top: 3%
  left 10px

  // Statistics text settings
  color #fff
  font-family Hack Nerd Font
  background rgba(#FFF, .1)
  padding 10px 10px 15px
  border-radius 5px

  .DiskUsageContainer
    width: 300px
    text-align: widget-align
    position: relative
    clear: both

  .DiskUsageContainer:not(:first-child)
    margin-top: 20px

  .DiskUsageWidget-title
    text-align: widget-align

  .DiskUsageStats-container
    margin-bottom 5px
    border-collapse collapse

  td
    font-size: 13px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)
    text-align: widget-align

  td.pctg
    float: right

  .DiskUsageWidget-title, p
    font-size 13px
    text-transform uppercase

  .DiskUsageLabel
    font-size 13px
    text-transform uppercase
    font-weight bold

  .DiskUsageBar-container
    width: 100%
    height: bar-height
    border-radius: bar-height
    float: widget-align
    clear: both
    background: rgba(#fff, .5)
    position: absolute
    margin-bottom: 5px

  .DiskUasgeBar
    height: bar-height
    float: widget-align
    transition: width .2s ease-in-out

  .DiskUasgeBar:first-child
    if widget-align == left
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .DiskUasgeBar:last-child
    if widget-align == right
      border-radius: bar-height 0 0 bar-height
    else
      border-radius: 0 bar-height bar-height 0

  .DiskUsageBar-used
    background: rgba(#c00, .5)
"""

humanize: (sizeString) ->
  sizeString + 'B'


renderInfo: (total, used, free, pctg, name) -> """
  <div class="DiskUsageContainer">
    <div class="DiskUsageWidget-title">#{name} #{@humanize(total)}</div>
    <table class="DiskUsageStats-container" width="100%">
      <tr>
        <td class="stat"><span class="used">#{@humanize(used)}</span></td>
        <td class="stat"><span class="free">#{@humanize(free)}</span></td>
        <td class="stat pctg"><span class="pctg">#{pctg}</span></td>
      </tr>
      <tr>
        <td class="DiskUsageLabel">used</td>
        <td class="DiskUsageLabel">free</td>
        <td class="DiskUsageLabel pctg">full</td>
      </tr>
    </table>
    <div class="DiskUsageBar-container">
      <div class="DiskUasgeBar DiskUsageBar-used" style="width: #{pctg}"></div>
    </div>
  </div>
"""

update: (output, domEl) ->
  disks = output.split('\n')
  $(domEl).html ''

  for disk, i in disks[..(@maxDisks - 1)]
    args = disk.split(' ')
    if (args[4])
      args[4] = args[4..].join(' ')
      $(domEl).append @renderInfo(args...)

  $(domEl).append ''
