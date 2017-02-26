import processing.serial.*;
import java.util.ArrayList;

ArrayList<Serial> serialInputs = new ArrayList();
int pointerX, pointerY;
int paintThrow = -1;
float compass, compassAdjust;
PGraphics canvas;

void setup() {
	size(776, 776);
	// fullScreen();

	setupPointerStart();
	setupCanvas();
	setupSerials();
}

void draw() {
	// Preproccessing
	processSerials();
	paintOnCanvas();

	// Display on screen
	image(canvas, 0, 0, width, height);
	drawPointer();
}

void drawPointer() {
	fill(0);
	ellipse(pointerX, pointerY, 5, 5);
}

void paintOnCanvas() {
	if (paintThrow != -1) {
		canvas.beginDraw();

		canvas.colorMode(HSB, 255);
		canvas.noStroke();
		canvas.translate(pointerX, pointerY);

		int paintBalls = paintThrow * 3;
		float opacityAdjust = paintThrow * 20;

		canvas.fill(0, 0, 200, 200);
		for (int i=0; i<paintBalls; i++) {
			float opacity = random(235 - opacityAdjust, 350 - opacityAdjust);
			float hue = abs(randomGaussian() * 255);
			canvas.fill(hue, 200, 255, opacity);

			float x = randomGaussian() * paintThrow * 10;
			float y = randomGaussian() * paintThrow * 10;
			float elSize = randomGaussian() * paintThrow * 15;
			canvas.ellipse(x, y, elSize, elSize);
		}
		
		canvas.endDraw();
		paintThrow = -1;
	}
}

void processVar(String key, int val) {
	switch (key) {

		case "y": // Pitch of left micro bit
			float yInPercent = ((val * -1.0) + 80.0) / 160.0;
			pointerY = int(yInPercent * height);
			break;

		case "a": // Button A is pressed on left micro bit
		case "b": // Button B is presed on the right micro bit
			// Set compass adjust
			compassAdjust = compass;
			break;

		case "x": // Compass head direction on left micro bit
			compass = val;
			float compassAfterAdjustment = (compass - compassAdjust + 60) % 360;
			float xInFromCompassInPercent = compassAfterAdjustment / 120.0;
			pointerX = int(xInFromCompassInPercent * width);
			break;

		case "g": // Throwing motion done with right micro bit
			paintThrow = val;
			break;

	}
}

void processSerials() {
	for (Serial serial : serialInputs) {
		if (serial.available() > 0) {
			String buffer = serial.readString();
			String[] vars = buffer.split("\\s+");

			for (String var : vars) {
				String[] keyval = var.split(":");

				if (keyval.length > 1) {
					String key = keyval[0];
					String valStr = keyval[1];

					try {
						int val = Integer.parseInt(valStr.trim());

						processVar(key, val);
					}
					catch (NumberFormatException e) { /* Do nothing */ }
				}
			}	
		}
	}
}

void setupPointerStart() {
	pointerX = width/2;
	pointerY = height/2;
}

void setupCanvas() {
	canvas = createGraphics(width, height);
	canvas.beginDraw();
	canvas.background(255);
	canvas.endDraw();
}

void setupSerials() {
	// Attempts to add all Micro bits to serials list
	for (String s : Serial.list()) {
		// Assumes Micro bits has "usbmodem" in their name
		if (s.indexOf("usbmodem") != -1) {
			try {
				serialInputs.add(new Serial(this, s, 115200));
			} 
			catch (RuntimeException e) {
				// Ignore Exceptions pertaining to busy ports
				if (e.getMessage().indexOf("Port busy") == -1) {
					throw e;
				}
			}
		}
	}
}


