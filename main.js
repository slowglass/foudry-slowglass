const MODULE_NAME = 'Slowglass Helper';

Hooks.once('init', () => {
  Hooks.once('ready', async () => {
    console.log(`✅ ${MODULE_NAME} | Ready`);
  });
});
