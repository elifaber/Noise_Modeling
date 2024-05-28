# Acoustics Modeling Functions

This repository contains several functions designed for modeling the propagation of sound from point sources and through walls with specific sound transmission classes (STCs) and absorption coefficients (note this does NOT use NRC.) It also includes a variety of helper functions useful for both this task and general acoustics problems.

## Main Features

### Sound Propagation and Wall Interaction Modelling
- **Point Source Propagation**: Creates a plot in order to model the emmissions of sound from point several point sources.
- **Wall Transmission**: Incorporate the effects of walls with specified STCs on sound transmission, including their absorption and reflection of sound.
- **Plotting**: Creates a contour plot with a certain number of lines according to your neads, and can also create a contour line at a specified dBSPL value.

### Helper Functions
These functions are designed to aid in a variety of acoustics calculations:
- **SPL_add**: Adds an array of dB SPL values.
- **SPL_decay**: Calculates the dB SPL of a sound source after a certain distance.
- **SPL_point**: Finds the dB SPL value for a point given the sources of sounds and the walls.
- Other helper functions are available and can be explored in the code.
  
