# CMPE 413 Final Project
This is the final project for CMPE 413 done by Daniel Cleaver and Mick Harrigan.

## Description
This project aims to create a functional 4x4 byte cache design in both VHDL, and later in physical layout.

The documentation on [descriptions](report/project_document.pdf) and [requirements](report/project_waveforms.pdf) are linked and contained within the `report` directory.

In addition to those files are some general output images and system design drawings used in the process of creating this cache design. This includes the testbench outputs in forms of both a `.txt` file and an output image.

## Usage and Verification
Usage of this project is done on the ITE375 computers, or a similar system with Cadence installed. To use the code, clone from the above URL.

To compile a section of the system for testing find the matching section within `Makefile`, or run
```
% make chip
```
to compile the top level chip.

## Testing
The provided testbench can be run with either
```
% make
```
or
```
% make chip_test
```

and returns the `.txt` output of the system.

Use either Vivado or the gui of cadence to see the output signals for each wire.
## Hierarchy of Chip Design
```
Chip
├── Cache Block
│   ├── 2 Bit Row Tags
│   ├── 4x4 Byte Cells
│   ├── Byte Decoder
│   └── Valid Tags
├── Hit/Miss Detector
├── Output Enable (Address)
├── Output Enable (Data)
├── Registers
└── State Machine
```
### Explanation
1. Chip: Top level chip that contains all other components of the cache
2. Cache Block: actual storage of the data
   1. Tag: tag that determines if data in and out match
   2. Cells: physical data bits
   3. Decoder: determines which byte is to be accessed
   4. Valid: bit that determines if the data is accessible or not
3. Hit/Miss: determines if the data was located in the cache or not
4. Out Enable (Address): Enables the outputting of the address to a different storage system on a read miss
5. Out Enable (Data): Enables the inout pins to be outputs when the CPU is to receive data from the cache
6. Registers: stores inputs from the CPU for use within the state machine
7. State Machine: controls current and next state of the cache system and what operations to do when