(ns meetup.main
  (:require [meetup.system :as system]))

(defn -main []
  (system/start-system))
