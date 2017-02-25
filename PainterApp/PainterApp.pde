import processing.serial.*;

Serial serialPointer;
float y, x;
float compassHead, compassHeadZeroPoint;
boolean button1Pressed = false;
PGraphics canvas;

void setup() {
	noStroke();
	size(512, 512);
	canvas = createGraphics(width, height);

	String portName = Serial.list()[1];
	serialPointer = new Serial(this, portName, 115200);
}

void draw() {
	// Preproccessing
	processVars();
	paintOnCanvas();

	// Display on screen
	clear();
	image(canvas, 0, 0, width, height);
	drawPointer();
}

void processVars() {
	if (serialPointer.available() > 0) {
		String buffer = serialPointer.readString();
		String[] vars = buffer.split("\\s+");

		for (String var : vars) {
			// println("var: "+var);
			String[] keyval = var.split(":");

			try {
				if (keyval.length > 1) {
					String key = keyval[0];
					String valStr = keyval[1];
					int valFloat = Integer.parseInt(valStr.trim());

					switch (keyval[0]) {
						case "y":
							float yInPercent = ((valFloat * -1.0) + 80.0) / 160.0;
							y = yInPercent * height;
							break;

						case "r": // When using roll
							float xFromRollInPercent = (valFloat + 80.0) / 160.0;
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
							compassHead = valFloat;
							println("compassHead: "+compassHead);
							float xInFromCompassInPercent = compassHead / 120.0;
							x = xInFromCompassInPercent * width;
							break;
					}
				}
			}
			catch (NumberFormatException e) {
				// Do nada
			}
			
		}

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