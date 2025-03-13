(ns example.math-test
  (:require [clojure.test :as t]))

(t/deftest one-plus-one
  (t/is (= (+ 1 1) 3) "One plus one equals 3!"))
