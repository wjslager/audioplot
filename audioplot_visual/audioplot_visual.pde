import java.nio.*; // ByteBuffer

byte bytes[];
float floats[];
int floatCount = 0;
float scale, y, waveHeight;


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
  for (int i=0; i<bytes.length/4; i++)
  {
    floats[i] = btof(bytes, i*4);
  }
  
  //smooth();
  textAlign(LEFT, TOP);
}


void draw()
{
  background(240);
  
  fill(20);
  text("Floats: " + floatCount + "\nBytes: " + bytes.length + "\n" + scale + " pixel per sample", 5, 5);

  for (int i=0; i<bytes.length/4; i++)
  {
    float val = floats[i] * waveHeight;

    stroke(200);
    line(i*scale, y, i*scale, y+val);

    stroke(20);
    point(i*scale, y+val);
  }
}


// Convert 4 bytes into a float
float btof(byte[] data, int offset)
{
  return ByteBuffer.wrap(data, offset, 4).order(ByteOrder.LITTLE_ENDIAN).getFloat();
}