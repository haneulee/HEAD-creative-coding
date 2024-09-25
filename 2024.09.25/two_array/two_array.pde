import java.util.Map;

HashMap<String, Integer> arr1 = new HashMap<String, Integer>();
HashMap<String, Integer> arr2 = new HashMap<String, Integer>();


void setup() {
  size(500, 400);
  background(255);
  String[] names = {"Liuliu", "Haneul", "Lise", "Peter", "Karina"};
  int[] values = {21, 70, 36, 40, 36};

  String[] names2 = {"Dog", "Cat", "Rabbit"};
  int[] values2 = {80, 20, 50};

  for (int i=0; i<values.length; i++) {
    arr1.put(names[i], values[i]);
  }

  for (int j=0; j<values2.length; j++) {
    arr2.put(names2[j], values2[j]);
  }
}

int distance = 1;
int count = 0;

void draw() {
  int widthArr1 = height/arr1.size();
  int i = 0;
  fill(0, 0, 255);
  noStroke();
  for (Map.Entry value : arr1.entrySet()) {
    String keyVal = value.getKey().toString();
    int val1 = arr1.get(keyVal);
    rect(width/2 - val1, (distance + widthArr1) * i, val1, widthArr1);
    text(keyVal + " " + val1, width/2 - val1 - 60, ((distance + widthArr1) * i) + widthArr1/2);
    i++;
  }
  
  fill(0, 255, 0);
  int j = 0;
  int widthArr2 = height/arr2.size();
  for (Map.Entry value : arr2.entrySet()) {
    String keyVal = value.getKey().toString();
    int val2 = arr2.get(keyVal);
    rect(width/2, (distance + widthArr2) * j, val2, widthArr2);
    text(keyVal + " " + val2, width/2 + val2 + 10, ((distance + widthArr2) * j) + widthArr2/2);
    j++;
  }
  count++;
  
  if(count == 1){
    save("two graph.png");
  }
}
