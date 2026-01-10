extends Node

const HOUR_PER_DAY: int = 24
const MINUTE_PER_HOUR: int = 60
const MINUTE_PER_DAY: int = MINUTE_PER_HOUR * HOUR_PER_DAY

const GAME_MINUTE_DURATION: float = TAU / MINUTE_PER_DAY

var game_speed: float = 5.0

var initial_day: int = 1
var initial_hour: int = 12
var initial_minute: int = 30

var time: float = 0.0
var current_minute: int = -1
var current_day: int = 0

signal game_time(time: float)
signal time_tick(day: int, hour: int, minute: int)
signal time_tick_day(day: int)

func _ready() -> void:
	set_initial_time()

func _process(delta: float) -> void:
	time += delta * game_speed * GAME_MINUTE_DURATION
	game_time.emit(time)
	
	recalculate_time()

func set_initial_time() -> void:
	var initial_total_minute = initial_day * MINUTE_PER_DAY + (initial_hour * MINUTE_PER_HOUR) + initial_minute
	
	time = initial_total_minute * GAME_MINUTE_DURATION
	
func recalculate_time() -> void:
	var total_minutes: int = int(time / GAME_MINUTE_DURATION)
	@warning_ignore("integer_division")
	var day: int = int(total_minutes / MINUTE_PER_DAY)
	var current_day_minutes: int = total_minutes % MINUTE_PER_DAY
	@warning_ignore("integer_division")
	var hour: int = int(current_day_minutes / MINUTE_PER_HOUR)
	var minute: int = int(current_day_minutes % MINUTE_PER_HOUR)
	
	if current_minute != minute:
		current_minute = minute
		time_tick.emit(day, hour, minute)
		
	if current_day != day:
		current_day = day
		time_tick_day.emit(day)
