extends Node

onready var audioPlayers = $AudioPlayers

func play_music(sound):
	var snd = load(sound)
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = snd
			audioStreamPlayer.play()
			break
		else:
			if audioStreamPlayer.stream != snd:
				audioStreamPlayer.stop()
				audioStreamPlayer.stream = snd
				audioStreamPlayer.play()

func play(sound):
	for audioStreamPlayer in audioPlayers.get_children():
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = load(sound)
			audioStreamPlayer.play()
			break
			
func stop_all():
	for audioStreamPlayer in audioPlayers.get_children():
		audioStreamPlayer.stop()

func play_solo(sound):
	if $AudioPlayers/AudioStreamPlayer8.playing: $AudioPlayers/AudioStreamPlayer8.stop()
	$AudioPlayers/AudioStreamPlayer8.stream = load(sound)
	$AudioPlayers/AudioStreamPlayer8.play()

func stop_solo():
	$AudioPlayers/AudioStreamPlayer8.stop()
