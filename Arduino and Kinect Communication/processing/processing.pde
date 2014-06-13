/*---------------------------------------------------------------
Created by: Leonardo Merza
Version: 1.0
----------------------------------------------------------------*/

/*---------------------------------------------------------------
Imports
----------------------------------------------------------------*/
import processing.serial.*;

/*---------------------------------------------------------------
Variables
----------------------------------------------------------------*/
// serial port object to access serial port
Serial myPort;
// int that will trigger comm with arduino
int eventTriggerValue = 'A';
// value to send to arduino
int testInt = 5;

/*---------------------------------------------------------------
Setup Method.
----------------------------------------------------------------*/
void setup() {
// prints out available serial ports and their COM port number
println(Serial.list());
// creates new port at 9600 BAUD from available port 0
myPort = new Serial(this, Serial.list()[0], 9600);
} // void setup()

/*---------------------------------------------------------------
Draw method. Writes values to serial port
----------------------------------------------------------------*/
void draw() {
// writes values to port
writeToPort();
} // void draw()

/*---------------------------------------------------------------
Writes values to serial port
----------------------------------------------------------------*/
void writeToPort() {
//write to serial for start reading values
myPort.write(eventTriggerValue);
// write a value to the port
myPort.write(testInt);
} // void writeToPort()
