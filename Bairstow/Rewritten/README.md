## Material, and how to use it:


* **bairstow.alg** is the program. The is a completely rewritten version, largely inspired by Julia implementation.

The question was: can we use a _modern_ programming style, that is to say with as few gotos as possible, using more procedures.

It turns out that is is possible: here, there is only _one_ goto, to simulate a _break_ in a loop.

### To compile and run the code:

* you can try both compilers: **jff-algol** and **marst**.
 
   * to use **jff-algol**, just type:

     ```
     >jff-algol bairstow.alg
     ```


   * to use **marts**, use the script **marst-it**:
   
      ```
      >./marst-it bairstow.alg
      ```


The executable is **bairstow** , in both cases.

### Verify results with SageMath:

* Edit *certify.sage* so that _pol_ contains the same data as _pol_ in _bair.alg_

* Just type:  **sage certify.sage**
