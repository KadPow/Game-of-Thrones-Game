void keyPressed()
{
  if (key == CODED){
    if(keyCode==RIGHT)
  {
    right = 1;
    jonSnow.direction = 1;
  }}
  if (key == CODED){
    if(keyCode == LEFT)
  {
    left = -1;
    jonSnow.direction = -1;
  }}
  
    if(key == ' ')
  {
    up = -1;
  }
  if (key == CODED){
    if(keyCode == DOWN)
  {
    down = 1;
  }}
}

void keyReleased()
{
  if (key == CODED){
    if(keyCode==RIGHT)
  {
    right = 0;
  }}
  if (key == CODED){
    if(keyCode == LEFT)
  {
    left = 0;
  }}

    if(key== ' ')
  {
    up = 0;
  }
  if (key == CODED){
    if(keyCode == DOWN)
  {
    down = 0;
  }}
}