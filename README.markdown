# parallel-povray

When rendering results of time varying computer simulation, it is nice to compute the images parallely because there are so many scene files for each time steps.

Parallel-povray script is designed to suit the purpose. It invokes several povray commands parallelly (by process). You can specify how many processes to run.

## Usage

    parallel-povray -nN [--confirm] [option...] file...

      -nN         How many processes to run. N is an integer number. (eg. 2)
      --confirm   Show interpreted arguments and povray commands that
                    parallel-povray publishes without running them.
      files       Povray scene files. Arguments that end with string ".pov" .
                    (eg. *.pov)
      options     Any other arguments which will be passed to povray unchanged.
                    (eg. -D +W1920 +H1440)

## Installation

   * Install povray (http://www.povray.org/) if not yet.
   * Please put parallel-povray.pl in any place you want and run it.
   * Parallel-povray assumes that an environment variable to run povray without specifing its place is set. To confirm this, try "which povray" on terminal.

## Example

    $ cd parallel-povray
    $ which povray
    /path/to/povray
    $ ls
    README.markdown         result00000000.pov      result00000002.pov
    parallel-povray.pl      result00000001.pov      result00000003.pov
    $ ./parallel-povray.pl -n2 -D +W1920 +H1440 *.pov
    $ ls
    README.markdown         result00000001.png      result00000003.png
    parallel-povray.pl      result00000001.pov      result00000003.pov
    result00000000.png      result00000002.png
    result00000000.pov      result00000002.pov

## Requirement

Needs povray (http://www.povray.org/) and an environment variable to run povray without specifing its place is set.

## Author

* Masayuki Takagi (kamonama@gmail.com)

## Copyright

Copyright (c) 2012 Masayuki Takagi (kamonama@gmail.com)

#License

BSD License
