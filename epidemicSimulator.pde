// Import java random lib
import java.util.Random;

float MEAN, STD_DEV;

// Declare new random generator
Random gen;

// Create a walker array
Walker[] walkers;

// Create graphs
Graph infGraph;
Graph deathGraph;

void setup() {
  // Set window size
  size(600, 600);
  
  // Disable stroke and enable anti-aliasing
  noStroke();
  smooth();

  // Define generator and graphs
  gen = new Random();
  infGraph = new Graph(color(100, 50, 50, 200));
  deathGraph = new Graph(color(50, 50, 100, 200));
  
  // Spawn a number of walkers with a specified size and infection spawn chance
  spawnWalkers(400, 10, 0.01);

  // Set normal distribution parameters
  MEAN = 3;
  STD_DEV = 1;
}

void draw() {
  int infected = 0;
  int dead = 0;
  int immune = 0;

  background(255);

  // For every agent (walker)
  for (int i = 0; i < walkers.length; i++) {
    if (walkers[i].inf) infected++;
    if (walkers[i].dead) dead++;
    if (walkers[i].immune) immune++;

    walkers[i].step();
    walkers[i].outcome(0.01, 0.001);
    walkers[i].infect(1/frameRate);
    walkers[i].render();
  }

  // Show simulation GUI
  fill(0);
  text("Agents: " + walkers.length, 6, 10);
  text("Susceptible: " + (walkers.length-infected-dead-immune), 6, 20);
  text("Recovered: " + immune, 6, 30);
  text("Infectious: " + infected, 6, 40);
  text("Dead: " + dead, 6, 50);
  text("Frame Rate: " + (float) round(frameRate*100)/100 + " (" + (float)round(millis()/frameCount*10)/10 + " ms)", 6, 60);
  text("Time: " + millis()/1000 + " s", 6, 70);

  // Update and render graphs
  infGraph.update(-infected);
  deathGraph.update(-dead);
  infGraph.render();
  deathGraph.render();
}
