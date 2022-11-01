extends Resource
class_name GLOBALS

# General
export(float) var slowmotion_speed = .3
export(float) var end_game_timer = 2
export(float) var mobile_cheat_bug_fix_time_sec = 0.2

export(int) var trail_indication_length = 30

export(float) var move_to_dicecam_time = .5

# Dice related
export(float) var dice_torque = 6.0
export(float) var dice_slowmotion_torque = 15.0
export(float) var dice_angular_max_velocity = 7.0
export(float) var dice_bounce_base = 600
export(float) var dice_bounce_slowmotion_multiplier = 3

export(int) var slowmotion_fov = 50
export(int) var normal_fov = 90


# SUS related
export(float) var sus_increment = 20
export(float) var sus_incrment_slowmotion = 30
export(float) var sus_tween_fill_time = .5
export(int) var sus_decay = 1


