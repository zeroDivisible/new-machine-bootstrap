Those are just some basic scripts to ease the pain of setting up a new machine.

(as of right now, because I'm using MBP, those are prepared to run on a new MacBook - next step is to prepare those for Archlinux)

### Steps:

1. install [``fabric``](http://fabfile.org)

1. clone this repo

1. **OSX only** make sure that remote login is allowed (``System Preferences`` / ``Sharing`` / ``Remote Login``)

1. to bootstrap localmachine run

    ```
    fab -H localhost TASK_NAME
    ```


