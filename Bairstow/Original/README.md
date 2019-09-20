## Material, and how to use it:

* The **scan[0-2].png** are scanned pages of the book.

* **bairstow.alg** is the program, after treatment by an OCR, and many corrections
as the OCR had a lot of problems with underlined keywords. But the program is exactly the same as in the book.

### To compile and run the code

* you can try both compilers: **jff-algol** and **marst**.

 * With **jff-algol**, just do:
   ```
   >jff-algol -F bairstow.alg
   ```
   The executable file is **bairstow**.

* With **marst** you must first translate the code in english, and then compile.  This is done with the script **marst-it**:

  ```
   >./marst-it  bairstow.alg
  ```



#### This works with **jff-algol**, but **marst-it** gives syntax errors.
