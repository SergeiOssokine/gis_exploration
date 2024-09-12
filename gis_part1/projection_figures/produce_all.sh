#!/bin/bash

types=(azimuthal cylindrical conical)
orientations=(normal transverse oblique)

for t in "${types[@]}"; do
    for o in "${orientations[@]}"; do
        echo $t $o
        python projections.py --orientation-type $o --projection-type $t
    done
done
