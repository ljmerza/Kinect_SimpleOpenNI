/*---------------------------------------------------------------
Created by: Leonardo Merza
Version: 1.0
----------------------------------------------------------------*/

/*---------------------------------------------------------------
Imports
----------------------------------------------------------------*/
// import kinect object
import SimpleOpenNI.*;

/*---------------------------------------------------------------
Variables
----------------------------------------------------------------*/
// create kinect object
SimpleOpenNI kinect;
// current position of current user
PVector position = new PVector();
// current kinect image storage
PImage kinectImage;
// create new user list
IntVector userList;
// size of dot to show center of mass position
int dotSize = 10;
// user colors
color[] userColor = new color[]{ color(255,0,0), color(0,255,0), color(0,0,255),
                                 color(255,255,0), color(255,0,255), color(0,255,255)};
/*---------------------------------------------------------------
Setup method. enables kinect and tracking. Creates draw window
----------------------------------------------------------------*/
void setup() {
  // create new kinect object
  kinect = new SimpleOpenNI(this);
  // enable depth sensor
  kinect.enableDepth();
  // enable rgb sensor
  kinect.enableRGB();
  // enable tracking but with no joint tracking
  kinect.enableUser();
  // start new user list
  userList = new IntVector();
  // create window size of depth info
  size(kinect.rgbWidth(),kinect.rgbHeight());
} // void setup()

/*---------------------------------------------------------------
Draw method. Updates kinect and displays it. Draws red dots at
tracked user's center of gravity
----------------------------------------------------------------*/
void draw() {
  // update kinect
  kinect.update();
  // get current image from kinect
  kinectImage = kinect.rgbImage();
  //draw current image at (0,0)
  image(kinectImage, 0, 0);

  //get list of tracked users
  kinect.getUsers(userList);

  //for each tracked user find center of gravity
  for (int i=0; i<userList.size(); i++) {
    // get current userID
    int userId = userList.get(i);

    // get center of mass of user (CoM) if available
    if(kinect.getCoM(userId, position)){
      // convert coordinates to projective space
      kinect.convertRealWorldToProjective(position, position);

      //print out current hand's id# and position
      println("userId: " + userId + ", position: " + position);

      // change draw color based on hand id#
      stroke(userColor[(i)]);
      // fill the ellipse with the same color
      fill(userColor[(i)]);
      // draw ellipse at x/y coordinates given ellipse size
      ellipse(position.x,position.y,dotSize,dotSize);

    }//if(kinect.getCoM(userId, position))
  } // for (int i=0; i<userList.size(); i++)
} // void draw()
