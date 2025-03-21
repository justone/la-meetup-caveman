(ns meetup.routes
  (:require [clojure.tools.logging :as log]
            [hiccup2.core :as hiccup]
            [meetup.cave.routes :as cave-routes]
            [meetup.goodbye.routes :as goodbye-routes]
            [meetup.hello.routes :as hello-routes]
            [meetup.system :as-alias system]
            [reitit.ring :as reitit-ring]))

(defn routes
  [system]
  [""
   (cave-routes/routes system)
   (hello-routes/routes system)
   (goodbye-routes/routes system)])

(defn not-found-handler
  [_request]
  {:status 404
   :headers {"Content-Type" "text/html"}
   :body (str
          (hiccup/html
           [:html
            [:body
             [:h1 "Not Found"]]]))})

(defn root-handler
  [system request]
  (log/info (str (:request-method request) " - " (:uri request)))
  (let [handler (reitit-ring/ring-handler
                 (reitit-ring/router
                  (routes system))
                 #'not-found-handler)]
    (handler request)))
