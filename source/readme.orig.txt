file: readme

The files in this directory are C++ programs implementing common algoritms in
Finance. They are released to the Internet community under the terms of the GNU
Public Licence. 

Author: Bernt Arne Oedegaard, Norwegian School of Management.

The author makes no guarantees about the correctness of these algoritms.  They
are meant as illustrations for academic purposes.

The routines have been tested on a Linux machine using the GNU C++ compiler. 

To test, unpack the zip file and then do 
 make tst

News:
  Jun 98. All routines have been made to conform to the new ANSI C++ standard
  as regards header file names (without the .h extension). 
  If you have an old compiler you may need to create small files on your 
  include path redirecting the include call to the old file name.
  For example, if your compiler cant find the file in the call 
    #include <vector>
  create a small file called "vector" that only contains 
    #include <vector.h>
  Do similar hacks for the other relevant headers.
  Hopefully, this is not a problem that will last long.
