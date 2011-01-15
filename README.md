# Bubbles!
Pop as many bubbles as you can in this amazing processing sketch.

# What exactly are you trying to do here?
I am trying my hand at some really primitive motion detection. Here is the basic process:
*	Subtract the color values of the current frame from the last frame.
*	Convert the result to grayscale.
*	Blur that juuuust a little.
*	Apply a threshold, reducing the image colors to black or white.
When all is said and done the white areas of the image represent motion.
# .pde?
Yes. It's a [Processing](http://processing.org/) sketch.