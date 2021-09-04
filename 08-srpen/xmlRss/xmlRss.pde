XML xml;

void setup() {
  size(320,240,OPENGL);
  xml = loadXML("https://www.irozhlas.cz/rss/irozhlas");
 //println(xml);
  XML[] children = xml.getChildren("item");

  for (int i = 0; i < children.length; i++) {
    String title = children[i].getString("title");
    String link = children[i].getString("link");
    String text = children[i].getContent();
    // println(title + ", " + coloring + ", " + name);
try{
    String [] lines = loadStrings(link);
    println(lines);
}catch(Exception e){

}
  }
}