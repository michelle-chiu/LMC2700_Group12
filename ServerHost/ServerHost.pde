import processing.net.*;

Server myServer;
Client myClient;
int val = 0;

import controlP5.*;
 
ControlP5 cp5;
 
String url1, url2;

PFont font = createFont("AgencyFB-Bold-48.vlw", 32);
 

void setup() {
  size(700, 400);
  cp5 = new ControlP5(this);
  cp5.addTextfield("Room Code").setPosition(20, 170).setSize(400, 70).setAutoClear(false).setFont(font);
  cp5.addTextlabel("Code Finder").setPosition(20, 70).setSize(400, 70).setFont(font).setText("Host");
  cp5.addBang("Submit").setPosition(400, 170).setSize(100, 70);
  cp5.addBang("Host").setPosition(400, 70).setSize(100, 70);
  // Starts a myServer on port 25565
  
}

void draw() {
  background(0);
}

void Submit() {
  url1 = cp5.get(Textfield.class,"Room Code").getText();
  myClient = new Client(this, roomCodeToIp(url1), 25565);
  myClient.write("Connected to server.");
}

void Host() {
  myServer = new Server(this, 25565);
  cp5.get(Textlabel.class, "Code Finder").setText(generateRoomCode(myServer.ip()));
}
