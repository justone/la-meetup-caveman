(ns meetup.goodbye.routes
  (:require [hiccup2.core :as hiccup]
            [meetup.system :as-alias system]))

(defn goodbye-handler
  [_system _request]
  {:status 200
   :headers {"Content-Type" "text/html"}
   :body (str
          (hiccup/html
           [:html
            [:body
             [:h1 "Goodbye, world"]]]))})

(defn routes
  [system]
  [["/goodbye" {:get {:handler (partial #'goodbye-handler system)}}]])
