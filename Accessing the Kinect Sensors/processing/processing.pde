/*-----------------------------------------------------------------------
Created by: Leonardo Merza
Version: 1.0

This program will find the closest object and put a red dot in the
window at the coordinates of that object
-----------------------------------------------------------------------*/

/*-----------------------------------------------------------------------
Imports
-----------------------------------------------------------------------*/
// import SimpleOpenNI
import SimpleOpenNI.*;

/*-----------------------------------------------------------------------
Variables
-----------------------------------------------------------------------*/
// create a kinect variable
SimpleOpenNI kinectObject;

// closest XYZ coordinates
int closestX;
int closestY;
int closestZ;

// coordinate of current pixel in array
int pixelCoordinate;
// current depth value of current pixel
int currentPixelDepthValue;
// depth values from kinect of all pixels
// of XY plane in a linear array
int[] depthValues;

// size of dot
int dotSize = 10;
// color scheme of dot
int redColor = 255;
int greenColor = 0;
int blueColor = 0;

/*-----------------------------------------------------------------------
Setup Method. Starts a new kinect object and turns on the depth and
IR sensors. Draws a window the size of the kinect depth image
-----------------------------------------------------------------------*/
void setup()
{
  // start the new kinect object
  kinectObject = new SimpleOpenNI(this);
  // enable to depth sensor
  //kinectObject.enableDepth();
  // enable the IR viewing mode
  kinectObject.enableDepth();
  // enable the RGB sensor
  kinectObject.enableRGB();

  // mirror is by default enabled
  kinectObject.setMirror(true);

  // set the window size as the height/width
  // of the kinect depth sensor
  size(kinectObject.depthWidth()*2,kinectObject.depthHeight());
} // void setup()

/*-----------------------------------------------------------------------
Draw method.  This method will update the kinect values and display a
red dot at the closest point from the kinect
-----------------------------------------------------------------------*/
void draw()
{
  // set the Z variable to the furthest
  // the kinect can see (8000mm)
  closestZ = 8000;
  //update the kinect data
  kinectObject.update();

  findClosestObject();

  // draw the ir image on the screen
  // at coordinates (0,0)
  image(kinectObject.depthImage(),0,0);
  // draw the RGB image on the screen
  // at coordinates (kinectObject.depthWidth(),0)
  image(kinectObject.rgbImage(),kinectObject.depthWidth(),0);

  // turn the draw color red
  fill(redColor,greenColor,blueColor);
  // draw a red circle that is 10x10 over
  // XY coordinates of closest point
  ellipse(closestX,closestY,dotSize,dotSize);
} // void draw()

/*-----------------------------------------------------------------------
 This method will find the closest depth value from the kinect
-----------------------------------------------------------------------*/
void findClosestObject() {
  // get the depth array from the kinect
  depthValues = kinectObject.depthMap();
  // for each row in the depth image
  for(int y=0;y<kinectObject.depthHeight();y++) {
    // look at each pixel in the row
    for(int x=0;x<kinectObject.depthWidth();x++) {
      // get current pixel coordinates
      pixelCoordinate = x + y * kinectObject.depthWidth();
      // get depth value of that coordinate
      currentPixelDepthValue = depthValues[pixelCoordinate];
      // if the current depth value is the closest
      if(currentPixelDepthValue > 0 && currentPixelDepthValue
          < closestZ) {
        // save the value of the new closest
        closestZ = currentPixelDepthValue;
        // and save XY coordinates
        closestX = x;
        closestY = y;
      } // if(currentDepthValue > 0 && currentDepthValue
    } // for(int x=0; x<kinect.depthWidth();x++)
  } // for(int y=0; y<kinect.depthHeight();y++)
}  // void findClosestObject()
