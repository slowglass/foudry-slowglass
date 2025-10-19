const MODULE_NAME = 'Slowglass Helper';

Hooks.once('init', () => {
  console.log(`${MODULE_NAME} | Initializing`);
});

Hooks.once('ready', async () => {
  console.log(`✅ ${MODULE_NAME} | Ready`);

  // Listen for actor updates
  Hooks.on("updateActor", (document, change, options, userId) => {
    console.log(`${MODULE_NAME} | updateActor hook fired. Document:`, document, `Change:`, change, `Options:`, options, `User ID:`, userId);

    // Check if HP value was changed
    if (change.system?.attributes?.hp?.value !== undefined) {
      const actor = document; // The document parameter is the Actor document
      const currentHp = actor.system.attributes.hp.value;
      const isDowned = currentHp <= 0; // Use isDowned as a general term for HP <= 0

      let statusId = null;
      let hasStatusEffect = false;

      if (actor.type === "character") {
        statusId = "unconscious";
        hasStatusEffect = actor.effects.some(effect => effect.statuses.has("unconscious"));
      } else if (actor.type === "npc") {
        statusId = "dead";
        hasStatusEffect = actor.effects.some(effect => effect.statuses.has("dead"));
      } else {
        // Ignore other actor types
        return;
      }

      if (isDowned && !hasStatusEffect) {
        actor.toggleStatusEffect(statusId, { active: true, overlay: true });
        console.log(`${MODULE_NAME} | Actor ${actor.name} is now ${statusId}.`);
      } else if (!isDowned && hasStatusEffect) {
        actor.toggleStatusEffect(statusId, { active: false, overlay: true });
        console.log(`${MODULE_NAME} | Actor ${actor.name} is no longer ${statusId}.`);
      }
    }
  });
});