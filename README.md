# Tsscssd
***

Mo' CSS, no problems! Introducing Tyler's Stupid Simple Cascading Style Sheet Deco-dementor ©

***


## What is this shit?

The TSSCSSD--sometimes pronounced "T two S C two S D" depending on level of G-ness--is a simple
CSS comment parser. Ta-da!

Having gotten fed up with overly complex solutions, I decided to write my own. KSS sucks and
CSS_Doc is BROKEN.

Besides, both were too heavy for my simple use case of "Hey man, I just wanna print my
comments out in an easy to reference style guide that is both easy on my eyes and wallet." Sub
in "sanity" for "wallet" because time is money and I have money on my mind.

The TSSCSSD will take your lame ass CSS comments, bust that shit out of their code chains, and
lay out fat stacks of tabular goodness for you all to party in. Or...lay out fat stacks of
tabular goodness in which for all you to part-ay.

## How do I get started with this shit?

Add this line to your application's Gemfile:

    gem 'tsscssd'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tsscssd

## How do I prep this shit?

*8Get crackin' on your CSS, homie!

Once you have shit handled--like HANDLED--you just need to throw down with this at the top of
your code:

    /*
    * Key        - Value
    */

You can slap as many silly ass key/value pairs as your little heart desires. A best practice
would be something like this shit:

    /*
    * Name          - THE Shit
    * Author        - <a href="mailto:lilweezy@youngmoney.biz">Mr. Wayne</a>
    * Description   - This file is full of cash money.
    */

In addition to your own silly ass key/value pairs, you get and additional couple *FOR FREE*!
These freebies are Filename (the file name...) and Dependencies (for all you mixin-ers).

Now, anything you want to have pulled out into the complimentary style guide, just comment
*directly* above the selector with a // <SPACE> to have that shit Fire in the Skied all up into
the mothership.

So like this:

    // This is pretty much the dopest siz-lector.
    .sizlector.the.bomb

###LISTEN

Every file you want to have not-jacked-up style documentation has to start with this
otherwise the docu-dementor will not correctly disturb your shit and will literally 
puke all over your shit.

###IF YOU DON'T WANT SHIT DOCU-DEMENTED

That's just silly. But, for things you want skipped, add the file name to the skip array
in the command (see below for mo' info).

*Nuff said.*

When he goes for his walk of assets/stylesheets, he'll just keep on strolling like a pimp.


##How do I set this shit OFF?

From your command line, make sure your ass in the right directory of your shit, then lay this down:

    bundle exec tsscssd --appname [YOUR APP NAME] --stylesheets [PATH TO YOUR STYLESHEETS] --type [WHAT KIND OF STYLESHEETS ARE WE DEALING WITH] --output [WHERE YOU WANT THE DOPENESS] --skip [AN ARRAY OF FILES TO SKIP] =

###Defaults

If you don't want to provide this badass with parameters, then this is what you get:

Appname           = 'My dope app'
Stylesheets       = CURRENT DIRECTORY + '/app/assets/stylesheets/'
@config[:output]  = CURRENT DIRECTORY + '/app/public'
@config[:type]    = 'scss'
@config[:skip]    = ['normalize']


## But...but what about all this other shit I want it to do?

If you have suggestions about how to improve the TSSCSSD, please feel free to tell your
collection of stuffed animals just before you cry yourself to sleep.

....................../´¯/)
....................,/¯../
.................../..../
............./´¯/'...'/´¯¯`- ¸
........../'/.../..../......./¨¯\
........('(...´...´.... ¯~/'...')
.........\.................'...../
.........."...\.......... _.- ´
............\..............(
..............\.............\...
