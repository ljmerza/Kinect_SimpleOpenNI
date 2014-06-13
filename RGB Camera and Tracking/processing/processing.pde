/*---------------------------------------------------------------
Created by: Leonardo Merza
Version: 1.0
----------------------------------------------------------------*/

/*---------------------------------------------------------------
Imports
----------------------------------------------------------------*/
import SimpleOpenNI.*;

/*---------------------------------------------------------------
Variables
----------------------------------------------------------------*/
// create kinect object
SimpleOpenNI  kinect;
// boolean if kinect is tracking
boolean tracking = false;
// current userid of tracked user
int userID;
// mapping of users
int[] userMapping;
// background image
PImage backgroundImage;
// image from rgb camera
PImage rgbImage;

/*---------------------------------------------------------------
Setup method. Enables kinect and draw window
----------------------------------------------------------------*/
void setup() {
  // start new kinect object
  kinect = new SimpleOpenNI(this);
  //enable depth camera
  kinect.enableDepth();
  // enable color camera
  kinect.enableRGB();
  // enable tracking
  kinect.enableUser();

  // turn on depth-color alignment
  kinect.alternativeViewPointDepthToImage(); 

  // load the background image
  backgroundImage = loadImage("wef.png");
  // create window width/height of rgb camera
  size(kinect.rgbWidth(),kinect.rgbHeight());
} // void setup()

/*---------------------------------------------------------------
Draw method.
----------------------------------------------------------------*/
void draw() {

  // display the background image first at (0,0)
  image(backgroundImage, 0, 0);
  //update kinect image
  kinect.update();

  // get the Kinect color image
  rgbImage = kinect.rgbImage();
  // prepare the color pixels
  loadPixels();
  // get pixels for the user tracked
  userMapping = kinect.userMap();

  // for the length of the pixels tracked, color them
  // in with the rgb camera
  for (int i =0; i < userMapping.length; i++) {
    // if the pixel is part of the user
    if (userMapping[i] != 0) {
      // set the sketch pixel to the rgb camera pixel
      pixels[i] = rgbImage.pixels[i];
    } // if (userMap[i] != 0)
  } // (int i =0; i < userMap.length; i++)

  // update any changed pixels
  updatePixels();
} // void draw()

/*---------------------------------------------------------------
When a new user is found, print new user detected along with
userID and start pose detection.  Input is userID
----------------------------------------------------------------*/
void onNewUser(SimpleOpenNI curContext, int userId){
  println("New User Detected - userId: " + userId);
  // start tracking of user id
  curContext.startTrackingSkeleton(userId);
} //void onNewUser(SimpleOpenNI curContext, int userId)

/*---------------------------------------------------------------
Print when user is lost. Input is int userId of user lost
----------------------------------------------------------------*/
void onLostUser(SimpleOpenNI curContext, int userId){
  // print user lost and user id
  println("User Lost - userId: " + userId);
} //void onLostUser(SimpleOpenNI curContext, int userId)
