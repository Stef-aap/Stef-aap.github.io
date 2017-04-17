# This __init__ module should be used
# in every path of the project
# except the "lang" directories
# Deploy.py will copy this __init__ to all necessary locations
# The orginal location of this file
#    Top_Path / dummy_setup / __init__.py
# where
#    Top_Path = 'D:/Data_Python_25/

# Get my own path
import os, sys
My_Path = sys._getframe().f_code.co_filename
My_Path = os.path.split ( My_Path ) [0]
if not ( My_Path ) :
  My_Path = os.path.join ( os.getcwd(), My_Path )
Top_Path = My_Path

# Search the top directory, which contains "__init__root.py"
Found = False
More  = True
while not ( Found ) and More :
  filename = os.path.join ( Top_Path, '__init__root.py' )
  Found = os.path.exists ( filename )

  # In distro, the sources are not always included,
  # so also test for pyc-version
  if not ( Found ) :
    filename += 'c'
    Found = os.path.exists ( filename )

  # if still not found, look one directory up, if possible
  if not Found :
    Top_Path = os.path.split ( Top_Path ) [0]

  More = Top_Path[0] and ( len ( Top_Path ) > 3 )
  #print Top_Path

# Stop if no __init__root found
if not ( Found ) :
  print 'Can''t find "__init__root.py"'
  print 'The program will be aborted'
  sys.exit ()

# Add the path of __init__root to PythonPath
if Top_Path not in sys.path :
  sys.path.append ( Top_Path )

#  Get the whole rest of the project, including myself
import __init__root

