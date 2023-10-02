gmx pdb2gmx -f 5UH5_f_r_noNA.pdb -o dom1.gro -water tip3p << 'INP'
9
INP
gmx editconf -f dom1.gro -o dom1_box.gro -c -d 1.0 -bt triclinic
gmx solvate -cp dom1_box.gro -cs spc216.gro -o dom1_solv.gro -p topol.top
gmx grompp -f ions.mdp -c dom1_solv.gro -p topol.top -o ions.tpr
gmx genion -s ions.tpr -o dom1_solv_ions.gro -p topol.top -pname NA -nname CL -neutral << 'INP'
13
INP
gmx grompp -f minim.mdp -c dom1_solv_ions.gro -p topol.top -o em.tpr
gmx mdrun -v -deffnm em
gmx grompp -f nvt.mdp -c em.gro -r em.gro -p topol.top -o nvt.tpr
gmx mdrun -v -deffnm nvt
gmx grompp -f npt.mdp -c nvt.gro -t nvt.cpt -r nvt.gro -p topol.top -o npt.tpr
gmx mdrun -v -deffnm npt
gmx grompp -f md.mdp -c npt.gro -t npt.cpt -p topol.top -o md.tpr
gmx mdrun -v -deffnm md
