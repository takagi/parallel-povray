# parallel-povray

When rendering results of time varying computer simulation, it is nice to compute the images parallely because there are so many scene files for each time steps.

Parallel-povray script is designed to suit the purpose. It invoke several povray commands paralley (by process). You can specify how many processes to use.

## Usage

Usage: parallel-povray -nN [--confirm] [option...] file...

  -nN         How many processes to use. N is an integer number (eg. 2)
  --confirm   Show interpreted arguments and povray commands that
                parallel-povray publishes without running them
  files       Arguments that end with string ".pov" (eg. *.pov)
  options     Any other arguments which will be passed to povray unchanged
                (eg. -D +W1920 +H1440)

## Requirement

Needs povray (http://www.povray.org/)

## Author

* Masayuki Takagi (kamonama@gmail.com)

## Copyright

Copyright (c) 2011 Masayuki Takagi (kamonama@gmail.com)

#License

BSD License
