# StackDrop Chaos

### **Game Overview & Core Mechanics**

**Gameplay:**  
The player drops blocks from above onto a platform. Each block has unique physics properties (e.g., weight, friction, bounce, stickiness, gravity effects). The goal is to stack blocks without letting them fall into the abyss. If any block falls off the platform, the game ends.

**Core Systems:**

- **Physics-Based Stacking:** No grid system—blocks interact dynamically using Godot's physics engine (RigidBody2D).
- **Block Variants:** Blocks have different attributes, such as mass, elasticity, friction, and special effects (e.g., explosions, magnets, anti-gravity).
- **Player Input:** Players can position and drop blocks but cannot directly control them after placement.
- **Gravity & Forces:** Some blocks alter gravity, push/pull others, or modify stacking behavior.
- **Win/Loss Conditions:** Game continues until a block falls off the platform, triggering a game-over state.
- **High Score:** The player is tracked based on the current height of the stacked blocks.

**Key Challenges & Considerations:**

- Ensuring **fair but chaotic** physics interactions.
- Balancing block effects to maintain **gameplay challenge and fun factor**.
- Performance optimization for **multiple physics objects interacting in real time**.
- Actually Implementing it.

## Description
A fresh twist on classic block-stacking games! Drop, stack, and balance physics-based blocks—each with unique properties like weight, bounce, stickiness, and even gravity manipulation. Will you build a stable tower or trigger a chaotic collapse? Be careful—if a block falls into the abyss, it's game over! Master the unpredictable physics and experiment with explosive, magnetic, and slippery blocks to outlast the challenge. Can you handle the chaos?
