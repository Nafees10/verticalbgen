import std.stdio;

import utils.misc;

import arsd.png;

import std.conv : to;

/*
 * Args format:
 * bgen <lines_horizontal>x<height_pixels> <line_width> <color0> <color1> <color2> <...> output_file_name
 */

void main(string[] args){
	debug{
		args.length = 5;
		args[1] = "32x128";
		args[2] = "16";
		args[3] = "FF3399";
		args[4] = "output.png";
	}
	import std.stdio;
	if (args.length < 4){
		writeln("verticalbgen version 0.1\n",
			"a program to generate random images with vertical lines\n",
			"copyright Nafees Hassan 2017");
		writeln("Not enough arguments");
		writeln("Arguments format:");
		writeln("verticalbgen [lines_counts]x[height_pixels] [line_width] [color0 in hex] [color1 in hex] [colors...] [output_file_name]");
	}else{
		uinteger actualHeight, width, lineWidth;
		{
			uinteger[2] size = readSize(args[1]);
			width = size[0];
			actualHeight = size[1];
			lineWidth = to!uinteger(args[2]);
		}
		// read the colors
		Color[] colors;
		{
			string[] colorStrings = args[3 .. args.length - 1];
			colors.length = colorStrings.length;
			for (uinteger i = 0; i < colorStrings.length; i ++){
				colors[i] = hexToColor(colorStrings[i]);
			}
		}
		// first tell user that I'm starting
		{
			writeln("vertical bgen starting - image information:");
			writeln("lines count:\t", width);
			writeln("height pixels:\t", actualHeight);
			writeln("total colors:\t", colors.length);
		}
		
		// now make an image
		TrueColorImage image = new TrueColorImage(cast(int)(width*lineWidth), cast(int)(actualHeight));
		uinteger actualWidth = width*lineWidth;
		Color[] colColor;
		for (uinteger col = 0; col < actualWidth; col ++){
			if (col%lineWidth == 0){
				colColor = generateColumn(colors, actualHeight);
			}
			// write this col
			for (uinteger row = 0; row < actualHeight; row ++){
				image.imageData.colors[(row * actualWidth) + col] = colColor[row];
			}
		}
		// write image to file
		writePng(args[args.length-1], image);
		{
			writeln("verticalbgen finished - image written to: \n\t", args[args.length-1]);
		}
	}

}

Color[] generateColumn(Color[] colors, uinteger height){
	import std.random;
	// chose a color
	Color chosenColor = colors[uniform(0, colors.length)];
	Color[] r;
	r.length = height;
	r[] = chosenColor;
	// now fade it into white
	float fadeR, fadeG, fadeB;
	fadeR = cast(float)(255 - chosenColor.r)/height;
	fadeG = cast(float)(255 - chosenColor.g)/height;
	fadeB = cast(float)(255 - chosenColor.b)/height;
	for (uinteger i = 0; i < height; i ++){
		r[i].r += cast(ubyte)(i*fadeR);
		r[i].g += cast(ubyte)(i*fadeG);
		r[i].b += cast(ubyte)(i*fadeB);
	}
	return r;
}

/// reads size from a <width>x<height> format, returns index0=width; index1=height
uinteger[2] readSize(string s){
	uinteger[2] size;
	for (uinteger i = 0; i < s.length; i ++){
		if (s[i] == 'x'){
			// read previous
			string width = s[0 .. i], height = s[i+1 .. s.length];
			// check if is valid
			if (width.length == 0 || height.length == 0 || !isNum(width) || !isNum(height)){
				throw new Exception("not a valid width/height");
			}
			size[0] = to!uinteger(width);
			size[1] = to!uinteger(height);
		}
	}
	return size;
}

///Converts hex color code to RGB
Color hexToColor(string hex){
	import utils.baseconv;
	ubyte r, g, b;
	uinteger den = hexToDenary(hex);
	//min val for red in denary = 65536
	//min val for green in denary = 256
	//the remaining value is blue
	if (den >= 65536){
		r = cast(ubyte)((den / 65536));
		den -= r*65536;
	}
	if (den >= 256){
		g = cast(ubyte)((den / 256));
		den -= g*256;
	}
	b = cast(ubyte)den;
	return Color(r, g, b);
}