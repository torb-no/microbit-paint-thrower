import processing.serial.*;
import java.util.ArrayList;

ArrayList<Serial> serialInputs = new ArrayList();
float y, x;
float compassHead, compassHeadZeroPoint;
boolean button1Pressed = false;
PGraphics canvas;

void setup() {
	noStroke();
	size(512, 512);
	canvas = createGraphics(width, height);

	serialInputs.add(new Serial(this, Serial.list()[1], 115200));
	serialInputs.add(new Serial(this, Serial.list()[2], 115200));
}

void draw() {
	// Preproccessing
	processSerials();
	paintOnCanvas();

	// Display on screen
	clear();
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

				try {
					if (keyval.length > 1) {
						String key = keyval[0];
						String valStr = keyval[1];
						int val = Integer.parseInt(valStr.trim());
						processVars(key, val);
					}
				}
				catch (NumberFormatException e) {
					// Do nothing
				}
			}
		}
	}
}

void processVars(String key, int val) {
	switch (key) {
		case "y":
			float yInPercent = ((val * -1.0) + 80.0) / 160.0;
			y = yInPercent * height;
			break;

		case "r": // When using roll
			float xFromRollInPercent = (val + 80.0) / 160.0;
			x = xFromRollInPercent * width;
			break;

		case "b": // Button B is pressed on first controller
			button1Pressed = true;
			break;

		case "a": // Button A is pressed on first controller
			// Set heading zero point (forward)
			compassHeadZeroPoint = compassHead;
			break;

		case "x": // When using compass
			compassHead = val;
			println("compassHead: "+compassHead);
			float xInFromCompassInPercent = compassHead / 120.0;
			x = xInFromCompassInPercent * width;
			break;
	}
}

void drawPointer() {
	fill(255);
	ellipse(x, y, 5, 5);
}

void paintOnCanvas() {
	if (button1Pressed) {
		
		canvas.beginDraw();
			canvas.noStroke();
			canvas.fill(200, 0, 0, 100);
			canvas.ellipse(x, y, 100, 100);
		canvas.endDraw();

		button1Pressed = false;
	}
}


// String getMicrobitPort() {

// }