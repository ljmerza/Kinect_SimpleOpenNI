/*---------------------------------------------------------------
Created by: Leonardo Merza
Version: 1.0

This class will connect to the serial port and accept data from
the kinect with an eventTriggerValue of 'A'
----------------------------------------------------------------*/

/*---------------------------------------------------------------
Variables
----------------------------------------------------------------*/
// current incoming value from kinect
int val;
// set data buffer from kinect
int enoughData = 2;
// int that will trigger comm with kinect
int eventTriggerValue = 'A';

/*---------------------------------------------------------------
Setup method. Begins serial communication at 9600 BAUD
----------------------------------------------------------------*/
void setup() {
// start serial communication
Serial.begin(9600);
} // void setup()

/*---------------------------------------------------------------
Loop method. Gets kinect values from serial port and
prints it out
----------------------------------------------------------------*/
void loop() {
getKinectValues();
} //void loop()

/*---------------------------------------------------------------
Gets Kinect values from serial port and prints it out
----------------------------------------------------------------*/
void getKinectValues()
{
// check if enough data has been sent from the computer:
if (Serial.available()>enoughData)
{
// read first value. begin communication
val = Serial.read();
// if value is the event trigger char 'A'
if(val == eventTriggerValue)
{
// read the most recent byte, which is the x-value
val = Serial.read();
Serial.println(val);
} // if(val == 'A')
} // if (Serial.available()>enoughData)
} // void getKinectValues()

