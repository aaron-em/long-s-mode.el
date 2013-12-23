ſ-mode.el
=========

Manual and automatic long 's' inſertion in Emacs buffers

Copyright (c) 2013 Aaron Miller. All rights reverſed.
ſhare and Enjoy!

Laſt reviſion: ſunday, December 22, 2013, ca. 21:00.

Author: Aaron Miller <me@aaron-miller.me>

Commentary
----------

The ["long s" (ſ)] [WIKI] is an archaic glyph in Engliſh
orthography. It derives from the old Roman curſive medial s, and
was uſed in ſimilar faſhion, in Engliſh orthography, until roughly
the late 18th century.

ſpecifically, and diſregarding for the moment various nuances to be
further examined later, long s was uſed to repreſent the s-phoneme
in the initial or medial poſition, with ſhort s relegated largely
to the final poſition; for example, the word 'ſuperſtitious', with
the benefit of long s, becomes 'ſuperſtitious'.

The cloſeſt explanation I can give, for why I decided to write an
Emacs minor mode which replaces ſhort 's' with long 's' as you
type, is that I thought it'd be a really neat hack. Having written
the code, I ſtill think it's a neat hack. Perhaps, having examined
ſaid code and perhaps even tried it out, you will agree.

ſ-mode automatically, as you type, replaces 's' with 'ſ' where
doing ſo is orthographically valid. The rules by which this
determination is made are as follows:

1. ſhort s is uſed at the end of a word (e.g. his, complains,
ſucceſs)

2. ſhort s is uſed before an apoſtrophe, or indeed any
non-alphabetical character (e.g. clos'd, us'd, neces-ſary)

3. ſhort s is uſed before the letter 'f' (e.g. ſatisfaction,
misfortune, transfuſe)

4. Compound words, with the firſt element ending in double s, and
thecond element beginning with s, are normally and correctly
written with a dividing hyphen (e.g. Croſs-ſtitch), but very
occaſionally may be written as a ſingle word, in which caſe the
middle letter 's' is written ſhort (e.g. croſsſtitch).

5. Long s is uſed initially and medially except in caſes
deſcribed above (e.g. ſong, uſe, preſs, ſubſtitute).

Theſe rules are derived from \"The Rules for Long S\", by Andrew
Weſt, which may be appreciated in full [on his blog] [WEſT].  All
credit for deriving thoſe uſage rules accrues to Mr. Weſt; the
blame for whatever lexicographical damage has been done by my
ſimplification of Mr. Weſt's rules is entirely mine.

ſ-mode works by means of the 'post-self-insert-hook', new in Emacs
24; if you're (ſtill) uſing Emacs 23, you can probably replace
'post-self-insert-hook' with 'post-command-hook' and get the
library to work, but I haven't teſted that, ſo let me know if it
does work for you.

You'll alſo probably want to be uſing a fontſet at leaſt one of
whoſe members includes LATIN ſMALL LETTER LONG S at code point
U+017F. Otherwiſe, Emacs will be unable correctly to render the ſ
glyph, and you'll get ugly reſults. (But there are plenty of fonts
out there which include ſ.)

Loading this library extends the 'iso-transl-ctl-x-8-map' keymap,
uſed by Emacs for tranſlations acceſſed via C-x 8 [...] ſequences,
ſuch that C-x 8 s s produces ſ. Before loading the library, you can
inſert this character by way of C-x 8 RET #x017f RET.

Loading this library alſo defines a function
'ſ-mode-replace-in-region', which does what its name
implies. ſ-mode need not be enabled for this function to work. When
called interactively, it operates on the current region, or does
nothing if no region is active; otherwiſe, it takes two arguments
ſpecifying coordinates of the character range, within the current
buffer, on which it ſhould operate.

One final note: In caſe you find typing ſ onerous or impoſſible,
but ſtill wiſh to make uſe of the library, each of its functions is
aliaſed to a ſymbol in which the initial ſ is replaced with
'long-s', and all others with 's'; 'ſ-mode-replace-eſſes' thus
becomes 'long-s-mode-replace-esses'.

Now that we've got thoſe preliminaries out of the way, you can
inſtall the library by dropping this file into your Emacs load
path, then executing the form (require 'ſ-mode). Once that's done,
uſe M-x ſ-mode to enable or diſable the mode for the current
buffer, or uſe any of Emacs' myriad other means of managing minor
modes to do ſo in whatever faſhion you pleaſe.

Bugs/TODO
---------

I'm aware of no bugs in this code, which is not the ſame as ſaying
none exiſt.

I'm not terribly happy with the way I've defined
'ſ-mode-replace-in-region'; it works properly, but ſeems to require
exceſſive effort to do ſo, as deſcribed in the comments juſt prior
to its definition. If you know Emacs well enough to tell me what
I'm doing wrong there, I'll be delighted to hear from you.

If there exiſts an uppercaſe verſion of the ſ-glyph, I am not aware
of it. Its abſence reſults in the loſs of orthographic information
when ſ-mode is in uſe, due to the tranſlation of the initial
majuſcule S-glyph into a lowercaſe ſ-glyph. An implementation of
the inverſe operation ſhould be able to recover this loſt
information from context; a candidate rule might be "For a given
'ſ' ſurrounded by majuſcules, or occurring in the initial poſition
of a word which follows a ſequence of non-alphanumeric characters,
replace it with 'S'; otherwiſe, replace it with 's'." Even ſo,
manual review and cleanup would likely be required.

As ſomething of a corollary to the preceding point, this library
does not implement tranſlation from ſ back to {S,s}. Perhaps
ſomeday I'll be inclined to write that code; perhaps you'll do ſo
before I get around to it, and delight me with a pull requeſt.

Miſcellany
----------

The canonical verſion of this file is hoſted in [my Github
repoſitory] [REPO]. If you didn't get it from there, great! I'm
happy to hear my humble efforts have achieved wide enough intereſt
to reſult in a fork hoſted ſomewhere elſe. I'd be obliged if you'd
drop me a line to let me know about it.

*The repository in which you find this file is named 'long-s-mode.el'
 for reasons of Github's apparent incapacity to support repositories
 whose names contain characters outside the ISO-8859-1 range.*

[WIKI]: http://en.wikipedia.org/wiki/Long_s
[REPO]: https://github.com/aaron-em/ſ-mode.el
[WEſT]: http://babelſtone.blogſpot.com/2006/06/rules-for-long-s.html#EnglishRules
