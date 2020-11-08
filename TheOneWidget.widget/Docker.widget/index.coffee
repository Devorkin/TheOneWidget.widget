command: "echo \"$(/usr/local/bin/docker container ls | grep -v 'CONTAINER ID' | wc -l) /$(/usr/local/bin/docker container ls -a | grep -v 'CONTAINER ID' | wc -l | tr -s ' ')\""
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

.DockerIcon {
  height: 48px
  width: 48px
}

.DockerLeftSide {
  float: left
  width: 30%
}

.DockerRightSide {
  float: right
  width: 70%
}

.DockerRunning {
  color: rgba(255,255,255,0.55)
}

.DockerContainersCount {
  color: rgba(255,255,255,0.75)
}

.DockerVagrantCount {
  color: rgba(255,255,255,0.75)
}
"""

render: -> """
  <div class='DockerLeftSide'>
    <img class='DockerIcon' src='TheOneWidget.widget/Docker.widget/Docker.png'>
  </div>     
  <div class='DockerRightSide'>
    <label class='DockerRunning'>Running:</p>
    <label class='DockerContainersCount'></p>
  </div>
"""

update: (output) ->
	$('.DockerContainersCount').html(output + 'Containers')