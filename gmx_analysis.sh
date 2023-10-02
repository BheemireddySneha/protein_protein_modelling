#import os
gmx trjconv -f traj_comp.xtc -s md_main.tpr -o traj_nojump.xtc -pbc nojump << INP
1
INP
#echo 1 1 |
gmx trjconv -f traj_nojump.xtc -s md_main.tpr -o md_protein_nojump_center.xtc -pbc mol -ur compact -center << INP
1
1
INP
# dump the first frame at time 0 into a *.pdb file
#echo 1 1 |
gmx trjconv -f md_protein_nojump_center.xtc -s md_main.tpr -o md_protein.pdb -center -ur compact -pbc mol -dump 0 << INP
1
1
INP

# create a trajectory input file .tpr (select the protein group at all times)
#echo 1 |
gmx convert-tpr -s md_main.tpr -o md_protein.tpr << INP
1
INP

# .pdb for frames 0, 25, 50, 75, 100
#echo 1 |
gmx trjconv -f md_protein_nojump_center.xtc -s md_protein.tpr -o md_protein_frame25.pdb -dt 25000 << INP
1
INP

# SYSTEM CHECK (select appropriate option)

# total energy
gmx energy -f ener.edr -o total_energy.xvg << INP
14
INP

# kinetic energy
gmx energy -f ener.edr -o kinetic_energy.xvg << INP
13
INP

# potential energy
gmx energy -f ener.edr -o potential_energy.xvg << INP
12
INP

# RMSF, RMSD AND R-GYR

# root mean square deviation (select C-alpha group)
#echo 3 3 |
gmx rms -f md_protein_nojump_center.xtc -s md_protein.pdb -o rmsd.xvg << INP
3
3
INP

# root mean square fluctuation (select C-alpha group)
#echo 3 |
gmx rmsf -f md_protein_nojump_center.xtc -s md_protein.pdb -o rmsf.xvg << INP
3
INP

# radius of gyration
#echo 3 |
gmx gyrate -f md_protein_nojump_center.xtc -s md_protein.pdb -o gyrate.xvg << INP
3
INP

# intra-protein hydrogen bonds
#echo 1 1 |
gmx hbond -f md_protein_nojump_center.xtc -s md_protein.tpr -num hbnum_Pro-Pro.xvg -hx hbhelix.xvg << INP
1
1
INP
