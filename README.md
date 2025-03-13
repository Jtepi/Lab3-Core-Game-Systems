# Lab3: Core Game Systems - Health, Damage & Respawn Pattern

## Overview  
This project is a Flappy Bird-style game that implements fundamental game systems for managing player state, including health tracking, damage handling, hazards, and a respawn system.

## Features  

### **Core Systems**  
**Health System**: The player starts with three hearts. Each collision with a hazard (pipe) removes one heart. If health reaches zero, the game ends.  
**Damage-Dealing Hazards**: The pipes act as obstacles, and colliding with them reduces health.  
**Respawn System**: When the player loses all health or hits the ground, a Game Over screen appears with an option to restart.  
**Score System**: The player earns points by successfully passing through pipes.  

### **Visual Feedback**  
**Health Display**: The UI includes heart icons that update dynamically as health decreases.  
**Damage Indication**: The player briefly flashes red when taking damage.  
**Game Over Screen**: When health reaches zero or the player collides with the ground, the Game Over screen appears with a restart button.  

## How to Play  
**Left-click** to make the player move upwards.  
**Avoid pipes** and the ground to stay alive.  
**Earn points** by passing through gaps between pipes.  
The game ends when the player runs out of health or collides with the ground.  

## Signals 
### **Signals Used**  
- **`player_hit()`** – Triggered when the player collides with a pipe (health decreases).  
- **`restart()`** – Emitted when the restart button is clicked.  
- **`hit()`** – Emitted when the player hits the ground (triggers game over).
- **`_on_timer_timeout()`** – Called when the Timer node times out, spawning a new pipe.  


## Lab Structure  
**Main Scene (`main.tscn`)**  
- **Player** (CharacterBody2D) – Handles movement and flapping.  
- **Pipes** (Area2D) – Hazards that reduce health.
- **Timer** (Timer) – Controls pipe spawning intervals.    
- **Ground** (Area2D) – Ends the game if touched.  
- **HealthUI** (Control) – Displays the player's health.  
- **GameOver** (CanvasLayer) – UI for restarting the game.  


**Scripts**  
- `main.gd` – Manages the game flow, spawning, health, and scoring.  
- `player.gd` – Controls player movement, flapping, and damage effects.  
- `pipe.gd` – Handles pipe movement and collision signals.  
- `game_over.gd` – Manages the restart button function.  
- `ground.gd` – Detects collisions with the player.  

