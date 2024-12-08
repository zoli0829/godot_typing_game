extends AudioStreamPlayer2D

@export var build_streams: Array[AudioStream]
@export var harvest_streams: Array[AudioStream]
@export var harvested_streams: Array[AudioStream]
@export var randomize_pitch = true
@export var min_pitch = 0.9
@export var max_pitch = 1.1


func play_random_build_sfx():
	if build_streams == null || build_streams.size() == 0:
		return
	
	if randomize_pitch:
		pitch_scale = randf_range(min_pitch, max_pitch)
	
	stream = build_streams.pick_random()
	play()


func play_random_ready_to_harvest_sfx():
	if harvest_streams == null || harvest_streams.size() == 0:
		return
	
	if randomize_pitch:
		pitch_scale = randf_range(min_pitch, max_pitch)
	
	stream = harvest_streams.pick_random()
	play()


func play_random_harvested_sfx():
	if harvested_streams == null || harvested_streams.size() == 0:
		return
	
	if randomize_pitch:
		pitch_scale = randf_range(min_pitch, max_pitch)
	
	stream = harvested_streams.pick_random()
	play()
