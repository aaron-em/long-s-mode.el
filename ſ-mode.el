;;; ſ-mode.el --- manual and automatic long 's' inſertion

;; Copyright (c) 2013 Aaron Miller. All rights reverſed.
;; ſhare and Enjoy!

;; Laſt reviſion: ſunday, December 22, 2013, ca. 21:00.

;; Author: Aaron Miller <me@aaron-miller.me>

;; This file is not part of Emacs.

;; This file is free ſoftware; you can rediſtribute it and/or modify
;; it under the terms of the GNU General Public Licenſe as publiſhed
;; by the Free ſoftware Foundation; either verſion 2, or (at your
;; option) any later verſion.

;; This file is diſtributed in the hope that it will be uſeful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNEſS FOR A PARTICULAR PURPOſE. ſee the GNU
;; General Public Licenſe for more details.

;; You ſhould have received a copy of the GNU General Public Licenſe
;; along with this program. If not, ſee `http://www.gnu.org/licenses'.

;;; Commentary:

;; The "long s" (ſ) [WIKI] is an archaic glyph in Engliſh
;; orthography. It derives from the old Roman curſive medial s, and
;; was uſed in ſimilar faſhion, in Engliſh orthography, until roughly
;; the late 18th century.

;; ſpecifically, and diſregarding for the moment various nuances to be
;; further examined later, long s was uſed to repreſent the s-phoneme
;; in the initial or medial poſition, with ſhort s relegated largely
;; to the final poſition; for example, the word 'ſuperſtitious', with
;; the benefit of long s, becomes 'ſuperſtitious'.

;; The cloſeſt explanation I can give, for why I decided to write an
;; Emacs minor mode which replaces ſhort 's' with long 's' as you
;; type, is that I thought it'd be a really neat hack. Having written
;; the code, I ſtill think it's a neat hack. Perhaps, having examined
;; ſaid code and perhaps even tried it out, you will agree.

;; ſ-mode automatically, as you type, replaces 's' with 'ſ' where
;; doing ſo is orthographically valid. The rules by which this
;; determination is made are as follows:

;; 1. Short s is uſed at the end of a word (e.g. his, complains,
;; ſucceſs)

;; 2. Short s is uſed before an apoſtrophe, or indeed any
;; non-alphabetical character (e.g. clos'd, us'd, neces-ſary)

;; 3. Short s is uſed before the letter 'f' (e.g. ſatisfaction,
;; misfortune, transfuſe)

;; 4. Short s is uſed after the letter 'f' (e.g. offset, beefsteak),
;; although not if the word is hyphenated (e.g. off-ſet, beef-ſteak)

;; 5. Compound words, with the firſt element ending in double s, and
;; thecond element beginning with s, are normally and correctly
;; written with a dividing hyphen (e.g. Croſs-ſtitch), but very
;; occaſionally may be written as a ſingle word, in which caſe the
;; middle letter 's' is written ſhort (e.g. croſsſtitch).

;; 6. Long s is uſed initially and medially except in caſes
;; deſcribed above (e.g. ſong, uſe, preſs, ſubſtitute).

;; Theſe rules are derived from "The Rules for Long S", by Andrew
;; Weſt, which may be appreciated in full on his blog [WEſT].  All
;; credit for deriving thoſe uſage rules accrues to Mr. Weſt; the
;; blame for whatever lexicographical damage has been done by my
;; ſimplification of Mr. Weſt's rules is entirely mine.

;; ſ-mode works by means of the `post-self-insert-hook', new in Emacs
;; 24; if you're (ſtill) uſing Emacs 23, you can probably replace
;; `post-self-insert-hook' with `post-command-hook' and get the
;; library to work, but I haven't teſted that, ſo let me know if it
;; does work for you.

;; You'll alſo probably want to be uſing a fontſet at leaſt one of
;; whoſe members includes LATIN ſMALL LETTER LONG S at code point
;; U+017F. Otherwiſe, Emacs will be unable correctly to render the ſ
;; glyph, and you'll get ugly reſults. (But there are plenty of fonts
;; out there which include ſ.)

;; Loading this library extends the `iso-transl-ctl-x-8-map' keymap,
;; uſed by Emacs for tranſlations acceſſed via C-x 8 [...] ſequences,
;; ſuch that C-x 8 s s produces ſ. Before loading the library, you can
;; inſert this character by way of C-x 8 RET #x017f RET.

;; Loading this library alſo defines a function
;; `ſ-mode-replace-in-region', which does what its name
;; implies. ſ-mode need not be enabled for this function to work. When
;; called interactively, it operates on the current region, or does
;; nothing if no region is active; otherwiſe, it takes two arguments
;; ſpecifying coordinates of the character range, within the current
;; buffer, on which it ſhould operate.

;; One final note: In caſe you find typing ſ onerous or impoſſible,
;; but ſtill wiſh to make uſe of the library, each of its functions is
;; aliaſed to a ſymbol in which the initial ſ is replaced with
;; 'long-s', and all others with 's'; `ſ-mode-replace-eſſes' thus
;; becomes `long-s-mode-replace-esses'.

;; Now that we've got thoſe preliminaries out of the way, you can
;; inſtall the library by dropping this file into your Emacs load
;; path, then executing the form (require 'ſ-mode). Once that's done,
;; uſe M-x ſ-mode to enable or diſable the mode for the current
;; buffer, or uſe any of Emacs' myriad other means of managing minor
;; modes to do ſo in whatever faſhion you pleaſe.

;;; Bugs/TODO:

;; I'm aware of no bugs in this code, which is not the ſame as ſaying
;; none exiſt.

;; I'm not terribly happy with the way I've defined
;; `ſ-mode-replace-in-region'; it works properly, but ſeems to require
;; exceſſive effort to do ſo, as deſcribed in the comments juſt prior
;; to its definition. If you know Emacs well enough to tell me what
;; I'm doing wrong there, I'll be delighted to hear from you.

;;; Miſcellany:

;; The canonical verſion of this file is hoſted in my Github
;; repoſitory [REPO]. If you didn't get it from there, great! I'm
;; happy to hear my humble efforts have achieved wide enough intereſt
;; to reſult in a fork hoſted ſomewhere elſe. I'd be obliged if you'd
;; drop me a line to let me know about it.

;;; Links:

;; [WIKI]: http://en.wikipedia.org/wiki/Long_s
;; [REPO]: https://github.com/aaron-em/long-s-mode.el
;; [WEſT]: http://babelstone.blogspot.com/2006/06/rules-for-long-s.html#EnglishRules

;;; Code:

;; Add 'C-x 8 s s' => 'ſ'
(define-key 'iso-transl-ctl-x-8-map (kbd "s s") [?ſ])

(defun ſ-mode-replace-eſſes (where)
  "Examine the character immediately prior to WHERE for
replacement according to the long 's' rules described in the
documentation for `ſ-mode'; if the character satisfies those
rules, replace it with an ſ. Further, if this produces a string
of three ſ characters, replace that string with 'ſsſ'.

  This function is used by `ſ-mode-replace-before-point', the
post-self-insert-hook function used by `ſ-mode', and also by
`ſ-mode-replace-in-region'."
  (let ((candidate (char-before (- where 1))))
    (save-excursion
      (goto-char where)
      (save-match-data
        (when (and (eq candidate ?s)
                   (save-excursion
                     (backward-char 1)
                     (and (not (looking-at "\\W")) ; (rules 1 and 2)
                          (not (looking-at "f")))) ; (rule 3)
                   (save-excursion
                     (backward-char 3)
                     (not (looking-at "f")))) ; (rule 4)
          ;; Replace short s with long s (rule 6)
          (progn
            (backward-char 1)
            (backward-delete-char 1)
            (insert "ſ")
            (forward-char 1))
          ;; Fix up triple-ſ (rule 5)
          (if (save-excursion
                (backward-char 4)
                (looking-at "ſſſ"))
              (progn
                (backward-char 1)
                (backward-delete-char 3)
                (insert "ſsſ")
                (forward-char 1))))))))

;; I don't understand why this works, when an otherwise identical
;; function which simply does ...(forward-char 1) (ſ-mode-munge-eſſes)
;; has no effect.
;; But it does work, and given the amount of effort it took to see
;; that it did, I'm not about to argue. (Adding a call to
;; `deactivate-mark' was what really turned the trick; all sorts of
;; text mangling occurred before I tried that in a fit of
;; desperation. Again, I don't understand why it should make a
;; difference, but it does.)
(defun ſ-mode-replace-in-region (from to)
  "Examine the current region, and replace any short 's'
characters which satisfy the long 's' rules described in the
documentation for `ſ-mode'. Called interactively, this function
operates on the current region (and does nothing if the region is
not active); otherwise, it requires FROM and TO arguments
identifying the coordinates of the range on which to operate."
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end))
                 (list nil nil)))
  (if (and from to)
      (save-excursion
        (deactivate-mark)
        (let (last-char)
          (goto-char from)
          (while (< (point) to)
            (forward-char 1)
            (setq last-char
                  (buffer-substring-no-properties (- (point) 1) (point)))
            (backward-delete-char 1)
            (insert last-char)
            (ſ-mode-replace-eſſes (point)))))))

(defun ſ-mode-replace-before-point ()
  "When `ſ-mode' is enabled and the current buffer isn't the
minibuffer, call `ſ-mode-replace-eſſes' with an argument of
`POINT'. This is the function `ſ-mode' uses to replace short 's'
with long 's' as you type."
  (when (and ſ-mode
             (not (window-minibuffer-p (selected-window))))
    (ſ-mode-replace-eſſes (point))))

(define-minor-mode ſ-mode
  "A minor mode to ſimplify the uſe of the long S glyph (ſ). When
ſ-mode is active, initial and medial ſhort 's' glyphs will be
replaced with long 's' (ſ) glyphs, according to the following
rules:

1. Short s is uſed at the end of a word (e.g. his, complains,
ſucceſs)

2. Short s is uſed before an apoſtrophe, or indeed any
non-alphabetical character (e.g. clos'd, us'd, neces-ſary)

3. Short s is uſed before the letter 'f' (e.g. ſatisfaction,
misfortune, transfuſe)

4. Short s is uſed after the letter 'f' (e.g. offset), although
not if the word is hyphenated (e.g. off-ſet)

5. Compound words, with the firſt element ending in double s, and
thecond element beginning with s, are normally and correctly
written with a dividing hyphen (e.g. Croſs-ſtitch), but very
occaſionally may be written as a ſingle word, in which caſe the
middle letter 's' is written ſhort (e.g. croſsſtitch).

6. Long s is uſed initially and medially except in caſes
deſcribed above (e.g. ſong, uſe, preſs, ſubſtitute).

Theſe rules are derived from \"The Rules for Long S\", by Andrew
Weſt, which may be appreciated in full at
`http://babelstone.blogspot.com/2006/06/rules-for-long-s.html#EnglishRules'.
All credit for deriving thoſe uſage rules accrues to Mr. Weſt;
the blame for whatever damage has been done by my ſimplification
of Mr. Weſt's rules is entirely mine.

Loading this library alſo extends `iſo-tranſl-ctl-x-8-map', the
keymap uſed for C-x 8 [...] character inſertion, ſuch that the
ſequence `C-x 8 s s' produces the ſ glyph. This is largely
becauſe the library would have otherwiſe been a real pain in the
aſs to write, given the number of times that glyph is uſed in
its code.

One final note: Should you be unable or disinclined to type ſ,
whether via C-x 8 s s or some more direct mapping, you may be
relieved to know that each function in this library has an alias
which is identically named save for the replacement of initial ſ
with 'long-s', and of any other ſ with 's'; for example,
`ſ-mode-replace-eſſes' becomes `long-s-mode-replace-esses'. This
enables you to make use of the library without requiring that you
directly enter any character not likely to be found on your
keyboard."
  :init-value nil
  :lighter " ſ"
  :global nil
  :keymap nil
  (if ſ-mode
      (add-hook 'post-self-insert-hook
                'ſ-mode-replace-before-point)
    (remove-hook 'post-self-insert-hook
                 'ſ-mode-replace-before-point)))

(make-variable-buffer-local 'ſ-mode)

(defalias 'long-s-mode-replace-esses
  'ſ-mode-replace-eſſes
  "An alias for `ſ-mode-replace-eſſes', q.v.")

(defalias 'long-s-mode-replace-in-region
  'ſ-mode-replace-in-region
  "An alias for `ſ-mode-replace-in-region', q.v.")

(defalias 'long-s-mode-replace-before-point
  'ſ-mode-replace-before-point
  "An alias for `ſ-mode-replace-before-point', q.v.")

(defalias 'long-s-mode
  'ſ-mode
  "An alias for `ſ-mode', q.v.")

(provide 'ſ-mode)

;; ſ-mode.el ends here
