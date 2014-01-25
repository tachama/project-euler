;;;; -*- coding: utf-8 -*-
;;;;
;;;; Problem 4
;;;;   A palindromic number reads the same both ways. The largest palindrome
;;;;   made from the product of two 2-digit numbers is 9009 = 91  99.
;;;;   Find the largest palindrome made from the product of two 3-digit numbers.
;;;;


;;;
;;; 回文チェック関連関数
;;;

(defun palindromep (s)
  "引数sが回文(文字列)かを調べる"
  (string= s (reverse s)))

(defun palindrome-num-pair-p (p)
  "整数のペアが回文となるかを調べる"
  (palindromep (princ-to-string (* (first p) (rest p)))))


;;;
;;; 整数のリスト、組み合わせ生成関連関数
;;;

(defun range (start end)
  "[start .. end)の整数のリストを作成する"
  (if (>= start end)
      ()   ; 再帰の終了条件 - 空リスト(NIL)を返す
      (cons start (range (1+ start) end))))

(defun combination (l1 l2)
  "2つのリストの要素の組み合わせを生成する"
  (flet ((subfunc (a) (mapcar #'(lambda (b) (cons a b)) l2)))
    ;; mapcar #'subfuncで、組み合わせのリストのリストを生成
    ;; reduce #'appendで、リストのリストを1つにまとめる
    (reduce #'append (mapcar #'subfunc l1))))

(defun pair-mult (p)
  "ペア(A . B)の積を返す"
  (* (first p) (rest p)))


;;;
;;; リストに対する最大値を探す (独自実装)
;;;
(defun maximum (func lst)
  "引数funcで評価した結果で、lstから最大のものを返す"
  (if (= 1 (length lst))
      (first lst)   ;; リストの要素が1つの場合は、その要素を返す
      (let* ((val1 (funcall func (first lst)))
	     (tmp (maximum func (rest lst)))
	     (val2 (funcall func tmp)))
	(if (>= val1 val2)
	    (first lst) tmp))))

(defun maximum-palindrome-pair (start end)
  "[start..end)間の整数リストから、積が回文となる最大のものを探す"
  (let* ((lst (range start end))
	 (pairs (combination lst lst))
	 (ppairs (remove-if-not #'palindrome-num-pair-p pairs)))
    (pair-mult (maximum #'pair-mult ppairs))))


(defun main (start end)
  (format t "~d~%" (maximum-palindrome-pair start end)))

(main 100 1000)  ;; target is 3-digit numbers.
