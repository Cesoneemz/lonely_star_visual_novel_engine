extends Node

#Arkhip font
func load_arkhip_font() -> DynamicFont:
	var arkhip_font = DynamicFont.new()
	var arkhip_font_data = DynamicFontData.new()
	arkhip_font_data.font_path = "res://Fonts/d9464-arkhip_font.ttf"
	arkhip_font.font_data = arkhip_font_data
	arkhip_font.size = 30
	
	return arkhip_font
