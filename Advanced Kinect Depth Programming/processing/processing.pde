/*---------------------------------------------------------------
Created by: Leonardo Merza
Version: 1.0

This class creates a 3D color image from the kinect depth sensor
and RGB camera
----------------------------------------------------------------*/

/*---------------------------------------------------------------
Imports
----------------------------------------------------------------*/
// import 3D rendering OPENGL
import processing.opengl.*;
// import kinect library
import SimpleOpenNI.*;

/*---------------------------------------------------------------
Variables
----------------------------------------------------------------*/
// kinect object
SimpleOpenNI kinectObject;
// to store current kinect image
PImage rgbImage;

// default zoom of z axis
int ZoomAxisZ = 1000;
// change Z axis zoom
float zoomZAxis = 1;
// starting point for XY veiwing - in middle
float rotateXAxis = 1023/2;
// storage for all of the kinect depth data
PVector[] depthPoints;
// the current point that we will be drawing
PVector currentPoint;
// sets how many pixels to process and draw
int vectorShading = 10;

/*---------------------------------------------------------------
Setup method. Draws a window 1024 x 768 and enables kinect
depth and RGB sensor. Redraws both images to line up
with each other
----------------------------------------------------------------*/
void setup() {
// creates a window 1024*768
// and uses OPENGL 3D rendering
size(1024, 768, OPENGL);
// start a new kinect object
kinectObject = new SimpleOpenNI(this);
// enable the kinect depth sensor
kinectObject.enableDepth();
// enable the kinect color camera
kinectObject.enableRGB();
// align RGB and depth pictures together
kinectObject.alternativeViewPointDepthToImage();
} // void setup()

/*---------------------------------------------------------------
Draw method. Updates kinect image, gets it, and translates the
image to view in draw window.
----------------------------------------------------------------*/
void draw() {
// draw the back ground black
background(0);
// update the kinect image
kinectObject.update();
// get the current image from the kinect
rgbImage = kinectObject.rgbImage();

// recrop image to half width size
// half height size and zoom back ZoomAxisZ
translate(width/2, height/2, -ZoomAxisZ);
// flip X axis around
rotateX(radians(180));
// map rotateXAxis variable from -180 to 180
// then convert to radians and input to rotateY
rotateY(radians(map(rotateXAxis, 0, width, -180, 180)));
// after rotating X/Y rotate Z on center axis
// by pressing up and down
translate(0,0,zoomZAxis*-ZoomAxisZ);

// get all depth vector points from kinect
depthPoints = kinectObject.depthMapRealWorld();
// for each depth point from the kinect get the
// current vector of that point and draw it
for (int i=0;i<depthPoints.length;i+=vectorShading) {
// get current depth point to draw
currentPoint = depthPoints[i];
// set the stroke color based on the color pixel
stroke(rgbImage.pixels[i]);
// color a point in the current vectors position
point(currentPoint.x, currentPoint.y, currentPoint.z);
} // for (int i=0;i<depthPoints.length;i+=vectorShading)
} // void draw()

/*---------------------------------------------------------------
Event driven method that moves image on X or Z axis to view
and prints keyCode for any key pressed for debugging.
----------------------------------------------------------------*/
void keyPressed(){
// if up is pressed then zoom in Z axis
if(keyCode == 38){
zoomZAxis = zoomZAxis + 0.01;
} // (keyCode == 38)
// if down is pressed then zoon out Z axis
if(keyCode == 40){
zoomZAxis = zoomZAxis - 0.01;
} // (keyCode == 40)
// if left is pressed then turn image left
if(keyCode == 37){
rotateXAxis = rotateXAxis + 1;
} // (keyCode == 37)
// if right is pressed then turn image right
if(keyCode == 39){
rotateXAxis = rotateXAxis - 1;
} // (keyCode == 39)

// print the current keyCode for the
// key you are pressing
println(keyCode);
} // void keyPressed()

/*---------------------------------------------------------------
If mouse is clicked in window then save image to where this
file is saved
----------------------------------------------------------------*/
void mousePressed(){
// save image
save("3D_Kinect_Image.png");
// print saved
println("saved!");
} // mousePressed()
