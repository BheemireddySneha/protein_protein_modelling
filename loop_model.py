# Loop refinement of an existing model
from modeller import *
from modeller.automodel import *
#from modeller import soap_loop

log.verbose()
env = environ()

# directories for input atom files
env.io.atom_files_directory = ['.', '/home/sneha/work/mos_mtrA']

# Create a new class based on 'loopmodel' so that we can redefine
# select_loop_atoms (necessary)
class MyLoop(loopmodel):
    # This routine picks the residues to be refined by loop modeling
    def select_loop_atoms(self):
        # One loop from residue 19 to 28 inclusive
        return selection(self.residue_range('1014:D', '1023:D')
                        ,self.residue_range('1090:D', '1097:D'))
        # Two loops simultaneously
        #return selection(self.residue_range('19:', '28:'),
        #                 self.residue_range('38:', '42:'))

m = MyLoop(env,
           inimodel='/home/sneha/work/mos_mtrA/2gwr.pdb',   # initial model of the target
           sequence='2gwr',                 # code of the target
           loop_assess_methods=assess.DOPE) # assess loops with DOPE
#          loop_assess_methods=soap_loop.Scorer()) # assess with SOAP-Loop

m.loop.starting_model= 1           # index of the first loop model
m.loop.ending_model  = 100           # index of the last loop model
m.loop.md_level = refine.very_fast  # loop refinement method

m.make()
