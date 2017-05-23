# Digital_Design_Project
Some VHDL src codes about my digital design project.

##funcion
Its funcion is very simple, just as follows.
When something is making noise, we all want to make it quite.
My project is aimed at geting its position or at least direction. Here, I just make my servo point at it.
'@' is the noise-maker.
'o' is my servo.
'*' is my sound sensor, which can only tell me if the sound if above the judge level.

----------------------------------------------------------
                          @
                        /
                       /
                      /
         *(a)        o           *(b)
-----------------------------------------------------------

##princple
As we all know, the speed of sound is about 340m/s, which means it takes some time of the sound to arrive at sensor a and sensor b.
We can easily measure the time it takes move from a to b.Therefore, we can get the location where the sound source may be.

##source code

###door
It recevies information from sensor and other blocks to control the whole process.
When the "door" receives a series of digital information, its states will change.
The state "Left" will change from '0' to '1', when it receive a pluse from left sensor, so will "Right".
Its output is Left xor Right,so that our counter can know when to start counting and when to end counting.
It will be reseted if other blocks feed back a reset signal.

###counter
When it receive '1' from door, it will start to count, and '0' means stop counting. 
If this counter runs for a too long time(511 us here), it will feed back a reset signal to the door block.
If this counter stops in a legal state, it will caculate a number and put the result out to the servo-driver with a start signal.

###servo-driver
This bolck will work when it receive start signal from counter block.
It can put out about 50 pluses. Each of them is in the same parameters. Cycle is 20ms, width is the result received from counter.

###barkdog
This dog will eat meat when we give it a beef(the start signal from counter).
As soon as it end eating, it will bark for a long time to make this system deaf to noise.

###top enity
Just make these parts a whole system.
