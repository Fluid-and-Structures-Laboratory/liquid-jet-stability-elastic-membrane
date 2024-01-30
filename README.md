# jet-stability
This repository contains all the files and codes pertaining to the paper "**Liquid jet stability through elastic planar nozzles**" (https://doi.org/10.1140/epjs/s11734-022-00656-w). Please contact Md. Emazuddin Alif (malif@vols.utk.edu) or Dr. Andrew Dickerson (adicker7@utk.edu, dickerson@utk.edu) for further details and information. We request everyone using any portion of our code to appropriately cite the parent paper.

## CAD Models and Descriptions
- Base_plate.ipt : Base plate along which the linear stage connected to the relaxation chamber is held
- Connector_ring : 3D printed ring connecting the relaxation chamber to the membrane. On later iterations it was replaced with metallic flanges sourced from Home Depot
- encoder_coupler.ipt : Couples the encoder to the linear stage moving the relaxation chamber
- encoder_mount.ipt: Mounts the rotary encoder on the base plate
- Relaxation chamber holder.ipt : Connects the relaxation chamber to the linear stage
- Relaxation chamber outer holder.ipt : Clamps the relaxation chamber to the Relaxation Chamber Holder
- punch_holder.ipt : Holds the punch parallel to vertical in order to create clean circular nozzles
- laminizer.rld : Laminarizes the flow inside the relaxation chamber

## MATLAB Codes and Descriptions
- calibration.m : Calibrates the pixel distance in each video with real life physical units (here mm). The diameter of the relaxation chamber flange is taken as the refence for calibration
- calibration_looper.m : Loops through all the images taken of the flange in a particular folder for calibration
- calibration_dia.m : Measures the diameter of the jet just as it is exiting the nozzle (in Pixels)
- calibration_dia_looper.m : Measures the diameter of the jet (in Pixels) for all the videos saved in the selected folder
- jet_breakup.m : Measures the breakup distance of the jet. (Optional) Recreates the video with jet breakup highl;ighted with a red line
- jet_breakup_looper.m : Measures the breakup distance of the jet of all the videos in the selected folder


