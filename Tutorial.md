### In order to test SollerOS: ###

#### If you are using Windows(preferably Windows XP or above): ####
  1. Unzip the newest archive from the Downloads section
  1. Double click on run.bat

#### If you are using Linux, BSD, Solaris, or some other good UNIX-based OS: ####
  1. Unzip the newest archive from the Downloads section
  1. Install qemu and nasm with apt-get, yum, deb, pkg-add, or whatever package manager you have`*`
  1. Open a terminal
  1. Navigate to the folder where you unzipped the archive
  1. Run "./run.sh" or "sh run.sh"

> `*`For Mac OS X you should go to macports.org and download and install macports which will let you download qemu and nasm. [Here is the link to the download page.](http://www.macports.org/install.php) You will also need GCC-the best way to obtain it is to sign up at the Apple Developer Center [here](http://developer.apple.com) and download and install Xcode.

### In order to develop apps/test the filesystem of SollerOS ###
You will need to install the latest JDK(Java Development Kit) and look at my programming
manual for information about the interrupts used to interface with SollerOS. You can also
look at the example programs and example batch scripts I have which should provide some
help for anyone who wants to test their programs on SollerOS.