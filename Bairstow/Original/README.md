## Material, and how to use it:

* The **scan[0-2].png** are scanned pages of the book.

* **bairstow.alg** is the program, after treatment by an OCR, and many corrections
as the OCR had a lot of problems with underlined keywords.

### To compile and run the code

* you can try both compilers: **jff-algol** and **marst**.

* There are 2 sripts for this: **jff** and **marst-it**.

Both first translate bairstow.alg in bairstow-trans.alg, just changing the french keywords into english ones.
Then the code is compiled (actually translated to C, and then compiled).

The executable is **bairstow-trans**

#### This works with *jff*, but *marst-it* gives syntax errors.