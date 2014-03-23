Those are just some basic scripts to ease the pain of setting up a new machine.

(as of right now, because I'm using MBP, those are prepared to run on a new MacBook - next step is to prepare those for Archlinux)

===

**Question:** why you didn't just use [``chef``](http://www.getchef.com/), [``puppet``](https://puppetlabs.com/) or [``ansible``](http://www.ansible.com/home)?

**Anwser:** because I had been using them (well, ``chef`` and ``ansible`` at least) for other projects, and never tried ``fabric``. Yes, ``fabric`` is not a provisioning tool, but it looked simple enough that it might in fact get the job done. And it did.

===

### Steps to do.

1. install [``fabric``](http://fabfile.org)

1. clone this repo

1. **OSX only**: make sure that remote login is allowed (``System Preferences`` / ``Sharing`` / ``Remote Login``)

1. to bootstrap localmachine run

    ```
    fab -H localhost bootstrap
    ```

1. to see all available tasks, run:

    ```
    fab --list
    ```


