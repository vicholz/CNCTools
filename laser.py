import os
import sys
import time
import fileinput
import re
import shutil
import glob

def main(argv):
	for arg in argv:
		if os.path.exists(arg):
			f = os.path.splitext(arg)
			inFile = f[0]+f[1]
			outFile = f[0]+'-laser'+f[1]
			shutil.copy(inFile,outFile)

			with open(inFile) as f:
				file = open(outFile, 'w')
				for line in f:
					line = re.sub('.*Z-[0-9].* F.*','M03', line)
					line = re.sub('.*Z[0-9].* F.*','M05', line)
					file.write(line)
				file.close()

if __name__ == "__main__":
	main(sys.argv[1:])