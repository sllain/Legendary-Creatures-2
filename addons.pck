GDPC                                                                               O   res://mods/addons/codeandweb.texturepacker/codeandweb.texturepacker_importer.gdb      
                      :   res://mods/addons/codeandweb.texturepacker/image_loader.gdl	       	                      5   res://mods/addons/codeandweb.texturepacker/plugin.cfgl      �                       N   res://mods/addons/codeandweb.texturepacker/texturepacker_import_spritesheet.gdW      �                      J   res://mods/addons/codeandweb.texturepacker/texturepacker_import_tileset.gd�"      �                      # The MIT License (MIT)
#
# Copyright (c) 2018 Andreas Loew / CodeAndWeb GmbH www.codeandweb.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

tool
extends EditorPlugin

var import_plugin_tilesheet = null
var import_plugin_spritesheet = null

func get_name():
	return "TexturePacker Importer"


func _enter_tree():
	import_plugin_tilesheet = preload("texturepacker_import_tileset.gd").new()
	add_import_plugin(import_plugin_tilesheet)
	import_plugin_spritesheet = preload("texturepacker_import_spritesheet.gd").new()
	add_import_plugin(import_plugin_spritesheet)


func _exit_tree():
	remove_import_plugin(import_plugin_spritesheet)
	import_plugin_spritesheet = null
	remove_import_plugin(import_plugin_tilesheet)
	import_plugin_tilesheet = null
# The MIT License (MIT)
#
# Copyright (c) 2018 George Marques
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

tool
extends Object

func load_image(rel_path, source_path, options):
	var flags = options.image_flags if "image_flags" in options else Texture.FLAGS_DEFAULT
	var embed = options.embed_internal_images if "embed_internal_images" in options else false

	var ext = rel_path.get_extension().to_lower()
	if not ext in ["png","jpg","webp","pvr","tga"]:
		printerr("Unsupported image format: %s. Use PNG, JPG, WEBP, PVR or TGA instead." % [ext])
		return ERR_FILE_UNRECOGNIZED

	var total_path = rel_path
	if rel_path.is_rel_path():
		total_path = ProjectSettings.globalize_path(source_path.get_base_dir()).plus_file(rel_path)
	total_path = ProjectSettings.localize_path(total_path)

	var dir = Directory.new()
	if not dir.file_exists(total_path):
		printerr("Image not found: %s" % [total_path])
		return ERR_FILE_NOT_FOUND

	if not total_path.begins_with("res://"):
		# External images need to be embedded
		embed = true

	var image = null
	if embed:
		image = ImageTexture.new()
		image.load(total_path)
	else:
		image = ResourceLoader.load(total_path, "ImageTexture")

	if image != null:
		image.set_flags(flags)

	return image
config_version=3
[plugin]

name="TexturePacker Importer"
description="Importer for SpriteSheets created using TexturePacker"
version="1.0.4"
author="Andreas Loew / CodeAndWeb GmbH"
script="codeandweb.texturepacker_importer.gd"
# The MIT License (MIT)
#
# Copyright (c) 2018 Andreas Loew / CodeAndWeb GmbH www.codeandweb.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

tool
extends EditorImportPlugin

var imageLoader = preload("image_loader.gd").new()

enum Preset { PRESET_DEFAULT }

# const TiledMapReader = preload("tiled_map_reader.gd")

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		imageLoader.free()

func get_importer_name():
	return "codeandweb.texturepacker_import_spritesheet"


func get_visible_name():
	return "SpriteSheet from TexturePacker"


func get_recognized_extensions():
	return ["tpsheet"]


func get_save_extension():
	return "res"


func get_resource_type():
	return "Resource"


func get_preset_count():
	return Preset.size()


func get_preset_name(preset):
	match preset:
		Preset.PRESET_DEFAULT: return "Default"


func get_import_options(preset):
	return []


func get_option_visibility(option, options):
	return true


func get_import_order():
	return 200


func import(source_file, save_path, options, r_platform_variants, r_gen_files):
	#print("Importing sprite sheet from "+source_file);
	
	var sheets = read_sprite_sheet(source_file)
	var sheetFolder = source_file.get_basename()+".sprites"
	create_folder(sheetFolder)
		
	for sheet in sheets.textures:
		var sheetFile = source_file.get_base_dir()+"/"+sheet.image
		var image = load_image(sheetFile, "ImageTexture", [])
		create_atlas_textures(sheetFolder, sheet, image, r_gen_files)

	return ResourceSaver.save("%s.%s" % [save_path, get_save_extension()], Resource.new())
	
	
func create_folder(folder):
	var dir = Directory.new()
	if !dir.dir_exists(folder):
		if dir.make_dir_recursive(folder) != OK:
			printerr("Failed to create folder: " + folder)


func create_atlas_textures(sheetFolder, sheet, image, r_gen_files):
	for sprite in sheet.sprites:
		if !create_atlas_texture(sheetFolder, sprite, image, r_gen_files):
			return false
	return true


func create_atlas_texture(sheetFolder, sprite, image, r_gen_files):
	var texture = AtlasTexture.new()
	texture.atlas = image
	var name = sheetFolder+"/"+sprite.filename.get_basename()+".tres"
	texture.region = Rect2(sprite.region.x,sprite.region.y,sprite.region.w,sprite.region.h)
	texture.margin = Rect2(sprite.margin.x, sprite.margin.y, sprite.margin.w, sprite.margin.h)
	r_gen_files.push_back(name)
	return save_resource(name, texture)


func save_resource(name, texture):
	create_folder(name.get_base_dir())
	
	var status = ResourceSaver.save(name, texture)
	if status != OK:
		printerr("Failed to save resource "+name)
		return false
	return true


func read_sprite_sheet(fileName):
	var file = File.new()
	if file.open(fileName, file.READ) != OK:
		printerr("Failed to load "+fileName)
	var text = file.get_as_text()
	var dict = JSON.parse(text).result
	if !dict:
		printerr("Invalid json data in "+fileName)
	file.close()
	return dict


func load_image(rel_path, source_path, options):
	return imageLoader.load_image(rel_path, source_path, options)
	
# The MIT License (MIT)
#
# Copyright (c) 2018 Andreas Loew / CodeAndWeb GmbH www.codeandweb.com
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

tool
extends EditorImportPlugin

var imageLoader = preload("image_loader.gd").new()

enum Preset { PRESET_DEFAULT }

# const TiledMapReader = preload("tiled_map_reader.gd")

func _notification(what):
	if what == NOTIFICATION_PREDELETE:
		imageLoader.free()

func get_importer_name():
	return "codeandweb.texturepacker_import_tileset"


func get_visible_name():
	return "TileSet from TexturePacker"


func get_recognized_extensions():
	return ["tpset"]


func get_save_extension():
	return "res"


func get_resource_type():
	return "Resource"


func get_preset_count():
	return Preset.size()


func get_preset_name(preset):
	match preset:
		Preset.PRESET_DEFAULT: return "Default"


func get_import_options(preset):
	return []


func get_option_visibility(option, options):
	return true


func get_import_order():
	return 200

func import(source_file, save_path, options, r_platform_variants, r_gen_files):
	var sheets = read_sprite_sheet(source_file)
	var sheetFolder = source_file.get_basename()+".sprites";
	create_folder(sheetFolder)

	var fileName = "%s.%s" % [source_file.get_basename(), "res"]

	var tileSet
	if File.new().file_exists(fileName):
		tileSet = ResourceLoader.load(fileName, "TileSet")
	else:
		tileSet = TileSet.new()

	var usedIds = []
	for sheet in sheets.textures:
		var sheetFile = source_file.get_base_dir()+"/"+sheet.image
		var image = load_image(sheetFile, "ImageTexture", [])
		r_gen_files.push_back(sheet.image)
		create_tiles(tileSet, sheet, image, usedIds)
	
	prune_tileset(tileSet, usedIds)	

	r_gen_files.push_back(fileName)
	ResourceSaver.save(fileName, tileSet)

	return ResourceSaver.save("%s.%s" % [save_path, get_save_extension()], Resource.new())

func prune_tileset(tileSet, usedIds):
	usedIds.sort()
	for id in tileSet.get_tiles_ids():
		if !usedIds.has(id):
			tileSet.remove_tile(id)


func create_folder(folder):
	var dir = Directory.new()
	if !dir.dir_exists(folder):
		if dir.make_dir_recursive(folder) != OK:
			printerr("Failed to create folder: " + folder)


func create_tiles(tileSet, sheet, image, r_usedIds):
	for sprite in sheet.sprites:
		r_usedIds.push_back(create_tile(tileSet, sprite, image))


func create_tile(tileSet, sprite, image):
	var tileName = sprite.filename.get_basename()
	
	var id = tileSet.find_tile_by_name(tileName)
	if id==-1:
		id = tileSet.get_last_unused_tile_id()
		tileSet.create_tile(id)
		tileSet.tile_set_name(id, tileName)

	tileSet.tile_set_texture(id, image)
	tileSet.tile_set_region(id, Rect2(sprite.region.x,sprite.region.y,sprite.region.w,sprite.region.h))
	tileSet.tile_set_texture_offset(id, Vector2(sprite.margin.x, sprite.margin.y))
	return id


func save_resource(name, texture):
	create_folder(name.get_base_dir())
	
	var status = ResourceSaver.save(name, texture)
	if status != OK:
		printerr("Failed to save resource "+name)
		return false
	return true


func read_sprite_sheet(fileName):
	var file = File.new()
	if file.open(fileName, file.READ) != OK:
		printerr("Failed to load "+fileName)
	var text = file.get_as_text()
	var dict = JSON.parse(text).result
	if !dict:
		printerr("Invalid json data in "+fileName)
	file.close()
	return dict


func load_image(rel_path, source_path, options):
	return imageLoader.load_image(rel_path, source_path, options)
	
