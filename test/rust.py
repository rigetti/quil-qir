import glob

from pyquil import Program
import quil_qir

for f in glob.glob("test/known_good_bc/*.bc"):
    Program(quil_qir.to_quil(f))
