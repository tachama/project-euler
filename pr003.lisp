;;;; -*- coding: utf-8 -*-
;;;;
;;;; Problem 3
;;;;   The prime factors of 13195 are 5, 7, 13 and 29.
;;;;   What is the largest prime factor of the number 600851475143 ?
;;;;

(defconstant +in-number+ 600851475143 "問題の入力値")
(defconstant +in-number2+ 13195 "問題の入力値(練習用)")

;;;
;;; 素数関連処理 (実践CommonLispの第8章のコードを利用)
;;;
(defconstant +first-prime+ 2 "最も小さな素数=2")
(defun primep (n)
  "nが素数か調べる"
  (when (> n 1)
    (loop for fac from +first-prime+ to (isqrt n) never (zerop (mod n fac)))))
(defun next-prime (n)
  "nよりも大きな最小の素数を返す"
  (loop for x from (1+ n) when (primep x) return x))

;;;
;;; 素因数分解を行う
;;;
(defun prime-factor (n)
  "nの素因数分解を行う"
  (prime-factor-sub n +first-prime+ '()))
(defun prime-factor-sub (n prm lst)
  "prime-factorのサブ関数"
  (cond
    ;; 値が1になったら処理終了
    ((= 1 n) lst)
    ;; 引数の素数で割り切れる場合は、lstに値を追加し同じ素数で再度実行
    ((= 0 (mod n prm)) (prime-factor-sub (/ n prm) prm (cons prm lst)))
    ;; 引数の素数で割り切れない場合は、次の素数を用いて実行
    (t (prime-factor-sub n (next-prime prm) lst))))

;; メイン関数
(defun main (num)
  (format t "~d~%" (apply #'max (prime-factor num))))

(main +in-number+)
