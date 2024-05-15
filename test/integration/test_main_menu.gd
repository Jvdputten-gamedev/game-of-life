extends GutTest


var main_menu_scene



# func before_all():
# 	main_menu_scene = preload("res://core/main_menu/main_menu.tscn").instantiate()


func test_clicking_options_disables_main_menu():
	main_menu_scene._on_options_button_down()
	assert_false(main_menu_scene.main_menu_container.visible)

func test_on_options_button_down_options_active():
	main_menu_scene._on_options_button_down()
	assert_true(main_menu_scene.options_menu.visible)
