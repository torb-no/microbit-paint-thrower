import processing.serial.*;
import java.util.ArrayList;

ArrayList<Serial> serialInputs = new ArrayList();
int pointerX, pointerY;
int paintThrow = -1;
float compass, compassAdjust;
PGraphics canvas;

void setup() {
	noStroke();
	size(1024, 1024);
	// fullScreen();
	canvas = createGraphics(width, height);
	canvas.beginDraw();
	canvas.background(255);
	canvas.endDraw();

	serialInputs.add(new Serial(this, Serial.list()[1], 115200));
	serialInputs.add(new Serial(this, Serial.list()[2], 115200));
}

void draw() {
	// Preproccessing
	processSerials();
	paintOnCanvas();

	// Display on screen
	image(canvas, 0, 0, width, height);
	drawPointer();
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

void processVar(String key, int val) {
	switch (key) {

		case "y": // Pitch of left microbit
			float yInPercent = ((val * -1.0) + 80.0) / 160.0;
			pointerY = int(yInPercent * height);
			break;

		case "a": // Button A is pressed on left microbit
			// Set heading zero point (forward)
			compassAdjust = compass;
			// println("compass: "+compass);
			break;

		case "x": // Compass head direction on left microbit
			compass = val;
			float xInFromCompassInPercent = ((compass - compassAdjust + 60) % 360) / 120.0;
			if (keyPressed) {
				println(compass + "\t" + compassAdjust + "\t" + xInFromCompassInPercent);
			}
			pointerX = int(xInFromCompassInPercent * width);
			break;

		case "g": // Throwing motion done with right micro bit
			paintThrow = val;
			break;

	}
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
