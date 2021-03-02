# Package Management

* `dpkg -L package-name`
  * List files installed by `package-name`  
* `dpkg -S /path/to/file`
  * Find which package installed `/path/to/file`
* `apt depends package-name`
  * Show tree of dependiences for `package-name`
* `apt rdepends package-name`
  * Show reverse dependencies (i.e. dependants) for `package-name`
* `aptitude why package-name`
  * Explain what explicitly installed packages caused `package-name`
   to be installed as a dependency

