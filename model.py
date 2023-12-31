from modeller import *

from modeller.automodel import *

env = environ()
a = automodel (env,alnfile='MTR_5uht.ali', knowns='5uht',sequence='MTR',assess_methods=(assess.DOPE, assess.GA341))

a.starting_model=1
a.ending_model=5

a.make()
