# Slowglass Helper

A Foundry VTT module.

## Installation

To install this module, you can use one of the following methods:

### Automatic Installation

1.  Open the Foundry VTT setup screen.
2.  Click on the "Add-on Modules" tab.
3.  Click the "Install Module" button.
4.  In the "Manifest URL" field, paste the following URL:
    `https://github.com/slowglass/foundry-slowglass/releases/latest/download/module.json`
5.  Click the "Install" button.

### Manual Installation

1.  Download the latest release zip file from the [releases page](https://github.com/slowglass/foundry-slowglass/releases).
2.  Extract the contents of the zip file into the `modules` directory of your Foundry VTT data folder.

## Development Installation

To install the latest development version of this module, use the following manifest URL:

`https://cdn.jsdelivr.net/gh/slowglass/foundry-slowglass@master/module.json`

## Local Development (Eccles Road)
The current assumption is that the developement directory will sit inside the Foundrt VTT Test server modules directory

In order to run the release script we need to run
```
powershell -ExecutionPolicy Bypass -File X:\game-data\13\test\Data\modules\foundry-slowglass\release.ps1
```
The reason for this is that the repo is located on a remote drive.