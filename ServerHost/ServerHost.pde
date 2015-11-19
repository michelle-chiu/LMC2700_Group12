import processing.net.*;

Server myServer = null;
Client myClient = null;
int val = 0;

import controlP5.*;
 
ControlP5 cp5;
 
String url1, url2;

String dataIn;
String prev;

String message = "";

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
  prev = dataIn;
  if (myServer != null) {
    //You know this is the host
    // Get the next available client
    Client thisClient = myServer.available();
    // If the client is not null, and says something, display what it said
    if (thisClient !=null) {
      String whatClientSaid = thisClient.readString();
      if (whatClientSaid != null) {
        fromClientAsServer(thisClient, whatClientSaid);
      }
    }
  } 
  if (myClient != null && myClient.available() > 0) {
    fromServerAsClient(myClient);
  }
}

/**
* Fired every time the server receives a new message from ONE OF THE clients.
* Mostly the messages received will be important to the game and will have to be
* relayed to the other clients here so they can update locally.
*/
void fromServerAsClient(Client client) {
  message += myClient.readString();
  if (myClient.available() > 0) {return;}
  print("CLIENT HEARD: " + message);
  message = "";
  client.clear();
}

/**
* Fired every time the LOCAL CLIENT hears something from the server.
* Mostly used to display something locally.
*/
void fromClientAsServer(Client client, String message) {
  String msg = client.ip() + " " + message;
  println("SERVER HEARD: " + msg);
  myServer.write("Hello, " + client.ip());
}

void Submit() {
  url1 = cp5.get(Textfield.class,"Room Code").getText();
  myClient = new Client(this, roomCodeToIp(url1), 25565);
  myClient.write("Hello, server!");
}

void Host() {
  myServer = new Server(this, 25565);
  cp5.get(Textlabel.class, "Code Finder").setText(generateRoomCode(myServer.ip()));
  myClient = new Client(this, myServer.ip(), 25565);
  myClient.write("Hello, server!");
}


