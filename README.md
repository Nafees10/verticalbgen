# verticalbgen
a program to generate simple random images for background, with randomely colored stripes/lines fading into white.
## Getting Started
These instructions will get you a copy of the binaries up and running on your machine.
### Prerequisites
You need the following to build verticalbgen:  
```
A D Language compiler (I used DMD)
dub package manager for D
an internet connection (for fetching dependencies), or the this dub package: "utils": "~>0.1.6"
```
### Building
If you do not have the sources yet, run the following:
```
git clone https://github.com/Nafees10/verticalbgen
```
Then, build the project using:
```
cd bgen
dub --build=release --force
```
The binary will be named `verticalbgen`.

---

## Usage
`cd` into the binary's directory, and execute the following to generate a random image:
```
./verticalbgen 5x2 32 000000 FFFFFF output.png
```
* `5x128` is the size of the image, as in 5 stripes/lines wide, and 128 pixels high
* `32` is the width of each stripe/line
* `000000 FFFFFF` these are the colors that the program can use, these can be more than two, and are to be separated by spaces
* `output.png` this is the name of the output file

Executing the above will output a file named `output.png` in the same directory. That file is our result.  

## Acknowledgments
Built using:
* [adamdruppe](https://github.com/adamdruppe)'s [arsd](https://github.com/adamdruppe/arsd).png and [arsd](https://github.com/adamdruppe/arsd).color
* my [utils](https://github.com/Nafees10/utils)
