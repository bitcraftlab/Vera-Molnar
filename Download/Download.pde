
// a litte script to download and view the images
// of the fantastic Vera Molnar without flash...

String domain = "http://www.veramolnar.com";
String output = "images";

for (int year = 1939; year <= 2012; year++) {

  // download xml file
  String[] lines = loadStrings(domain + "/xml/" + year + ".xml");

  // drop the first line, it may be malformed
  lines[0] = "";

  // fix ampersands
  String data = join(lines, "\n").replaceAll("&", "&amp;");

  // parse it!
  XML xml = parseXML(data);

  // get list of images
  XML[] images = xml.getChildren("image");

  // download the images
  for (XML image : images) {

    // extract url and filename
    String url = domain + "/" + image.getString("fichier");
    String[] parts = split(url, "/");
    String filename = output + "/" + parts[parts.length - 1];

    // now, download the image and save it
    println("Downloading " + url);
    saveBytes(filename, loadBytes(url));
  }
}

println("done.");