command: "echo \"$(/usr/local/bin/docker container ls | grep -v 'CONTAINER ID' | wc -l)\""
refreshFrequency: 10000

style: """
  background:rgba(#FFF, .1)
  border-radius:5px
  font-family: Hack Nerd Font
  height: 60px
  left: 0.5%
  margin:0
  padding: 10px
  top: 90%
  width: 250px

.VirtualMachinesIcon {
  height: 48px
  width: 48px
}

.VirtualMachinesLeftSide {
  float: left
  width: 30%
}

.VirtualMachinesRightSide {
  float: right
  width: 70%
}

.VirtualMachinesRunning {
  color: rgba(255,255,255,0.55)
}

.VirtualMachinesDockerCount {
  color: rgba(255,255,255,0.75)
}

.VirtualMachinesVagrantCount {
  color: rgba(255,255,255,0.75)
}
"""

render: -> """
  <div class='VirtualMachinesLeftSide'>
    <img class='VirtualMachinesIcon' src='TheOneWidget.widget/VirtualMachines.widget/Docker.png'>
  </div>     
  <div class='VirtualMachinesRightSide'>
    <label class='VirtualMachinesRunning'>Running:</p>
    <label class='VirtualMachinesDockerCount'></p>
  </div>
"""

update: (output) ->
	$('.VirtualMachinesDockerCount').html(output + 'Containers')