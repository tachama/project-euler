;; Problem 1
;;   If we list all the natural numbers below 10 that are multiples of 3 or 5,
;;   we get 3, 5, 6 and 9. The sum of these multiplies is 23.
;;
;;   Find the sum of all the multiplies of 3 or 5 below 1000.

(defconstant +in-number+ 1000 "問題の入力値")

(defun multiplesp (a b)
  "aがbの倍数かを調べる"
  (= (mod a b) 0))

(defun multp-3or5 (a)
  "引数aが、3あるいは5で割り切れる場合に真 - XXX:マクロを使って簡単にできない？"
  (or (multiplesp a 3) (multiplesp a 5)))

(defun sum (lst) "リストの和を求める" (apply #'+ lst))

(defun lists (n)
  "xより小さい整数のリストを生成する - XXX:もっとシンプルにできないか？"
  (reverse (lists-sub (- n 1))))

(defun lists-sub (n)
  "lists関数のサブルーチン"
  (if (= n 0) nil
      (cons n (lists-sub (- n 1)))))

(defun main (n)
  "main関数; nより小さい整数で3,5のどちらでも割り切れない整数の和"
  (format t "~d~%" (sum (remove-if-not #'multp-3or5 (lists n)))))

;; メイン関数の実行
(main +in-number+)
