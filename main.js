import { MODULE_NAME } from "./main.js";
import { ActorManager } from "./actor-manager.js";

Hooks.once('init', () => {
  console.log(`${MODULE_NAME} | Initializing`);
});

Hooks.once('ready', async () => {
  console.log(`✅ ${MODULE_NAME} | Ready`);

  // Listen for actor updates
  const actorManager = new ActorManager();
  Hooks.on("updateActor", actorManager.handleUpdate.bind(actorManager));
});