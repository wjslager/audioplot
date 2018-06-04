import java.nio.*; // ByteBuffer

byte bytes[];
float floats[];
int floatCount = 0;
float scale, y, waveHeight;

// Number of clipping samples (outside of -1 to 1 range)
int clipCount = 0;


void setup()
{
  size(1024, 512);
  noLoop();

  bytes = loadBytes("../outfile");

  floatCount = int(bytes.length/4);
  scale = float(width)/floatCount;
  y = height*0.5;
  waveHeight = height*0.5;

  // Convert bytes array into float array
  floats = new float[floatCount];
  for (int i=0; i<floatCount; i++)
  {
    floats[i] = btof(bytes, i*4);
  }

  //smooth();
  textAlign(LEFT, TOP);
}


void draw()
{
  background(240);

  // Waveform
  for (int i=0; i<floatCount; i++)
  {
    float val = floats[i] * waveHeight;

    // Check for clipping
    // Clipping samples are drawn in red
    if (floats[i] > 1 || floats[i] < -1) {
      clipCount++;
      stroke(200, 150, 150);
    } else {
      stroke(200);
    }

    line(i*scale, y, i*scale, y-val);

    stroke(20);
    point(i*scale, y-val);
  }

  // Statistics
  fill(20);
  text("Samples: " + floatCount + "\n" + scale + " pixel per sample", 5, 5);
  
  if (clipCount > 0) println(clipCount + " clipping samples!");
  
  //\n" + clipCount + " clipping samples"

  saveFrame("plot.png");
}


// Convert 4 bytes into a float
float btof(byte[] data, int offset)
{
  return ByteBuffer.wrap(data, offset, 4).order(ByteOrder.LITTLE_ENDIAN).getFloat();
}