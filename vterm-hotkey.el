;;; -*- lexical-binding: t -*-
;;; vterm-hotkey.el --- Control vterm buffers with hotkeys.
;;
;; Copyright 2024 rootatpixel
;;
;; This program is free software: you can redistribute it and/or modify it under the
;; terms of the GNU General Public License as published by the Free Software Foundation,
;; either version 3 of the License, or (at your option) any later version.
;; This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
;; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the GNU General Public License for more details. You should have received a copy of
;; the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>. 
;;
;;
;;
;;; Code
(require 'vterm)

(defgroup vterm-hotkey
  nil
  "Control vterm buffers with hotkeys"
  :group 'vterm)

(defcustom vterm-hotkey-buffer-prefix "VTermHK"
  "Prefix for vterm-hotkey buffers"
  :type 'string
  :group 'vterm-hotkey)

(defvar vterm-hotkey-buffer-alist '()
  "The alist of vterm-hotkey-buffers and their hotkeys in the form (key . buffer)")


;; Functions
(defun vterm-hotkey-get-buffer-name (key)
  "Return a buffer name for the vterm-hotkey buffer bound to key"
  (concat vterm-hotkey-buffer-prefix "<" (symbol-name key) ">"))

(defun vterm-hotkey-bound-p (key)
  "Check if key is in vterm-hotkey-buffer-alist"
  (not (eq nil (assoc key vterm-hotkey-buffer-alist))))

(defun vterm-hotkey-open (key)
  "Open vterm-hotkey buffer bound to key"
  (switch-to-buffer
   (cdr
    (assoc key vterm-hotkey-buffer-alist))))

(defun vterm-hotkey-create (key)
  "Create a new vterm-hotkey buffer"
  (unless (vterm-hotkey-bound-p key)
    (add-to-list 'vterm-hotkey-buffer-alist
		 `(,key . ,(vterm (vterm-hotkey-get-buffer-name key))) t)))
		 			       
;; Interactive Functions
;;;###autoload
(defun vterm-hotkey (key)
  "Create or switch to a vterm-hotkey buffer"
  (interactive "kHotkey:")
  (let '(keysym (intern key))
   (if (vterm-hotkey-bound-p keysym)
       (vterm-hotkey-open keysym)
     (vterm-hotkey-create keysym))))

(provide 'vterm-hotkey)
;;; vterm-hotkey.el ends here
