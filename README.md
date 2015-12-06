Purescript everywhere
=====================

Demonstrates how to run a purescript program in various environments.

```
cd purescript
pulp browserify > app.js
cd ..
```

Browser
-------

```
cd browser
cp ../purescript/app.js .
open index.html
```

Java
----

```
cd java
cp ../purescript/app.js .
javac Main.java
java Main
```
