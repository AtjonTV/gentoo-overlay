# Custom Fork

I (AtjonTV) made a custom fork of the original repo, I
already had an Overlay but I though it would be nice to
fork the LLVM-Gentoo repository and use what I can from there.

I know that some packages where deadly. I experienced it
before I removed those packages.

The original is a "LLVM/Linux" Overlay, and
this is a "GNU/Linux but wants LLVM/Linux" Overlay now.

Dont worry, I will slowly try to migrate everything back
to LLVM/Linux as I dont like GNU either.

I will also keep every non-LLVM/Linux ebuild from the
original Overlay up-to-date.

Still. Use this Overlay at your own risk. Packages may
only work out for me.

Also, I will license my fork under the WTFPL.

## Releases

I am making releases so that I have a list of changes for a given timestamp.

Previously I used the scheme `year.count-count`, the fist count is for the release/month and the second for the patch in a month/release.

From now on I will use the format `year.month.release-rpatch`. release is the count of releases in a month, and patch is the counf of patches in the release; e.g. `-r1`, this will be obmitted when on each first release though.

As of this writing, the last release I will rerelease in the new format is `2020.9.3-r1`.

Finally, here the original Readme:

# Private Gentoo Overlay

This is my private Gentoo Overlay and is not indented to
be added by others. I used the generic name `localrepo`
for that purpose and also disabled auto sync.

Some ebuilds are hacks and only work on my machine to
just get the software installed and tracked by portage
for easily removal and upgrades.

You are free to take all ebuilds and copy them to your
own local repo. There is no copyleft or copyright. The WTFPL is fully permissive for EVERYTHING :)

Use all ebuilds at your own risk. I'm not responsible if
you brick your Gentoo install. Pay attention to eventual
notes I have added to individual ebuilds.
