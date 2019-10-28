# WiFi Transmission Speed Widget
#
# Joe Kelley
#
# Unlike the little "signal strength" icon, this simple little widget tells you how fast your WiFi connection is actually communicating
# It uses the built-in OS X airport framework to get the actual transmission speed calculated using the most recent wireless network traffic
# It is particularly useful for finding the best place to position your computer and/or access point for best performance.

command: "/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep TxRate | cut -c 18-20"

refreshFrequency: 10000

# Adjust the style settings to suit. I've set the position to be just below the WiFi icon in my menu bar.

style: """
  margin:0
  padding:0px
  left: 222px
  top: 403px
  width: 107px
  background:rgba(#FFF, .1)
  border-radius:5px
  height: 78px

  .icon
    height:48px
    width:48px
    display: block;
    margin-left: auto
    margin-right: auto
    width: 50%;

  .service
    text-align:center
    padding: 10px

  .primaryInfo, .secondaryInfo
    font-family: Helvetica Neue
    padding: 0px
    margin: 0px
    text-align: center
    
  .primaryInfo
    font-size:10pt
    font-weight:bold
    color: rgba(255,255,255,0.75)
    text-align: center
    
  .secondaryInfo
    font-size:8pt
    color: rgba(255,255,255,0.75)
    text-align: center
"""

render: -> """
   <div><td class='service'>
   <img class="icon" src="TheOneWidget.widget/wifi-tx-speed.widget/icon48.png">
   <p class='primaryInfo'>WiFi Tx</p>
   <p class='secondaryInfo'></p>
   </td></div>
"""

update: (output) ->
	if(output)
  		$('.secondaryInfo').html(output + 'Mbps')
  	else
  		 $('.secondaryInfo').html(output + 'No WiFi')