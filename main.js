const MODULE_NAME = 'Slowglass Helper';

Hooks.once(`foundry-slowglass.init`, () => {
  console.log(`${MODULE_NAME} | Initializing`);
});

Hooks.once(`foundry-slowglass.ready`, () => {
  console.log(`${MODULE_NAME} | Ready`);
});