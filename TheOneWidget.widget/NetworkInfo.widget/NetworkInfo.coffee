#--------------------------------------------------------------------------------------
# Please Read
#--------------------------------------------------------------------------------------
# The images used in this widget are from the Noun Project (http://thenounproject.com).
#
# They were created by the following individuals:
#   Ethernet by Michael Anthony from The Noun Project
#   Wireless by Piotrek Chuchla from The Noun Project
#
#--------------------------------------------------------------------------------------

# Execute the shell command.
script.location = "TheOneWidget.widget/NetworkInfo.widget"
command: script.location + "/NetworkInfo.sh"

# Set the refresh frequency (milliseconds).
refreshFrequency: 5000

# Render the output.
render: (output) -> """
  <table id='services'></table>
"""

# Update the rendered output.
update: (output, domEl) -> 
  dom = $(domEl)
  
  # Parse the JSON created by the shell script.
  data = JSON.parse output
  html = ""
  
  # Loop through the services in the JSON.
  for svc in data.service
  
    # Start building our table cell.
    html += "<td class='NetworkInfoService'>" 
    
    # If there is an IP Address, we should show the connected icon. Otherwise we show the disable icon.
    # If there is no IP Address, we show "Not Connected" rather than the missing IP Address.
    if svc.ipaddress == ''
      html += "  <img class='NetworkInfoIcon' src='" + script.location + "/images/" + svc.name + "_disabled.png'/>"
      html += "  <p class='NetworkInfoPrimaryInfo'>Not Connected</p>" 
    else
      html += "  <img class='NetworkInfoIcon' src='" + script.location + "/images/" + svc.name + ".png'/>"
      html += "  <p class='NetworkInfoPrimaryInfo'>" + svc.ipaddress + "</p>" 
    
    # Show the Mac Address.
    html += "  <p class='NetworkInfoSecondaryInfo'>" + svc.macaddress + "</p>"
    html += "</td>"
  
  # Set our output.
  $(services).html(html)

# CSS Style
style: """
  margin:0
  padding:0px
  left: 0.5%
  top: 32%
  width: 230px
  background:rgba(#FFF, .1)
  border-radius:5px
      
  .NetworkInfoService
    text-align:center
    padding:2px
    
  .NetworkInfoIcon
    height:32px
    width:32px
    
  .NetworkInfoPrimaryInfo, .NetworkInfoSecondaryInfo
    font-family: Hack Nerd Font
    padding:0px
    margin:2px
    
  .NetworkInfoPrimaryInfo
    font-size: 13px
    font-weight:bold
    color: rgba(255,255,255,0.75)
    
  .NetworkInfoSecondaryInfo
    font-size: 13px
    color: rgba(255,255,255,0.75)
"""
