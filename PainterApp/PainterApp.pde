import processing.serial.*;

Serial serialPointer;
float y, x;

void setup() {
	size(512, 512);
	String portName = Serial.list()[1];
	serialPointer = new Serial(this, portName, 115200);
}

void draw() {

	clear();
	processVars();
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
					float valFloat = Float.parseFloat(valStr.trim());

					switch (keyval[0]) {
						case "y":
							float yInPercent = ((valFloat * -1.0) + 80.0) / 160.0;
							y = yInPercent * height;
							break;

						case "r": // When using roll
							float xInPercent = (valFloat + 80.0) / 160.0;
							x = xInPercent * width;
							println("var: "+var);
							break;

						case "c": // When using compass
							// None here so far
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
	ellipse(x, y, 5, 5);
}


// String getMicrobitPort() {

// }