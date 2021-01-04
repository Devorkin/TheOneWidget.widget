command: "echo \"$(/Applications/\"VMware Fusion.app\"/Contents/Public/vmrun list vms | sed 's|Total running VMs:||' | sed 's|\/.*$||')\""
refreshFrequency: 10000

style: """
  background:rgba(#FFF, .1)
  border-radius:5px
  font-family: Hack Nerd Font
  height: 60px
  left: 30%
  margin:0
  padding: 10px
  top: 90%
  width: 250px

.FusionIcon {
  height: 48px
  width: 48px
}

.FusionLeftSide {
  float: left
  width: 30%
}

.FusionRightSide {
  float: right
  width: 70%
}

.FusionRunning {
  color: rgba(255,255,255,0.55)
}

.FusionContainersCount {
  color: rgba(255,255,255,0.75)
}

.FusionVagrantCount {
  color: rgba(255,255,255,0.75)
}
"""

render: -> """
  <div class='FusionLeftSide'>
    <img class='FusionIcon' src='TheOneWidget.widget/Fusion.widget/Fusion.png'>
  </div>     
  <div class='FusionRightSide'>
    <label class='FusionRunning'>Running:</p>
    <label class='FusionContainersCount'></p>
  </div>
"""

update: (output) ->
	$('.FusionContainersCount').html(output + 'VMs')